//
//  ViewController.swift
//  swift-collection-view-compositional-layout
//
//  Created by 정희수 on 5/8/25.
//

import UIKit

class ViewController: UIViewController {

    enum Section: Int, CaseIterable {
        case filter
        case list
    }
    
    enum Item: Hashable {
        case filter(String)
        case list(Entity)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    var entities: [Entity] = [Entity(), Entity(), Entity(), Entity(), Entity()]
    var filters: [String] = ["일", "이삼", "사오육", "칠팔구십", "일이삼사오", "육칠팔구십일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "COMPOSITIONAL LAYOUT"
        
        configureHierarchy()
        configureDataSource()
    }
}

extension ViewController: UICollectionViewDelegate {
    func configureHierarchy() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemGray6
        // collectionView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func configureDataSource() {
        // cell
        let filterCellRegistration = UICollectionView.CellRegistration<CategoryCollectionViewCell, AnyHashable>(cellNib: UINib(nibName: CategoryCollectionViewCell.reuseIdentifier, bundle: nil)) { (cell, indexPath, data) in
                  
            guard let item = data as? Item else { return }
            
            if case let .filter(title) = item {
                cell.label.text = title
            }
        }

        let listCellRegistration = UICollectionView.CellRegistration<ListCollectionViewCell, AnyHashable>(cellNib: UINib(nibName: ListCollectionViewCell.reuseIdentifier, bundle: nil)) { (cell, indexPath, data) in
                        
            cell.backgroundColor = .systemGray4
        }
        
        let footerSupplementaryRegistration = UICollectionView.SupplementaryRegistration<CollectionFooterView>(supplementaryNib: UINib(nibName: CollectionFooterView.reuseIdentifier, bundle: nil), elementKind: UICollectionView.elementKindSectionFooter) {
            (footer, string, indexPath) in
            
            footer.label.text = "FOOTER"
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, data: AnyHashable) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else { return nil }
            
            switch section {
            case .filter:
                return collectionView.dequeueConfiguredReusableCell(using: filterCellRegistration, for: indexPath, item: data)
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: data)
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, indexPath) in
            switch kind {
            case UICollectionView.elementKindSectionFooter:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: footerSupplementaryRegistration, for: indexPath)
            default:
                return nil
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        Section.allCases.forEach { section in
            snapshot.appendSections([section])

            switch section {
            case .filter:
                snapshot.appendItems(filters.map { .filter($0) })
            case .list:
                snapshot.appendItems(entities.map { .list($0) })
            }
        }
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .filter:
                // 아이템 크기
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .absolute(37))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // 그룹 (수평 스크롤용)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .absolute(37))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

                // 섹션 구성 (헤더/푸터 없음)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
                section.interGroupSpacing = 8
                
                return section

            case .list:
                // 아이템 크기
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)

                // 그룹 (수직 스크롤용)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                
                // 섹션 구성 (푸터 있음)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 1
                section.boundarySupplementaryItems = [
                    NSCollectionLayoutBoundarySupplementaryItem(
                        layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44)),
                        elementKind: UICollectionView.elementKindSectionFooter,
                        alignment: .bottom
                    )
                ]
                
                return section
            }
        }, configuration: config)
        
        return layout
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

