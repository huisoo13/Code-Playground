# UICollectionView Compositional Layout 샘플

하나의 `UICollectionView`에 가로로 스크롤하는 카테고리와 세로 목록을 함께 배치하는 UIKit 예제입니다.

## 구성

- **카테고리 섹션** — 예상 너비를 사용하는 필터 셀을 가로로 배치하고 연속 스크롤을 적용합니다.
- **목록 섹션** — 전체 너비를 차지하는 행과 섹션 하단 푸터를 표시합니다.
- **데이터 소스** — 두 섹션의 항목을 `NSDiffableDataSourceSnapshot`으로 구성해 컬렉션 뷰에 적용합니다.

## 실행하기

Xcode에서 `swift-collection-view-compositional-layout.xcodeproj`를 열어 실행합니다. 상단 카테고리와 하단 목록을 각각 스크롤해 섹션별 배치를 확인할 수 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ViewController.swift`](Scene/ViewController.swift) | 섹션별 레이아웃, 셀 및 푸터 등록, 초기 스냅샷 |
| [`Scene/Item/CategoryCollectionViewCell.swift`](Scene/Item/CategoryCollectionViewCell.swift) | 카테고리 셀 |
| [`Scene/Item/ListCollectionViewCell.swift`](Scene/Item/ListCollectionViewCell.swift) | 목록 셀 |
| [`Scene/Item/CollectionFooterView.swift`](Scene/Item/CollectionFooterView.swift) | 목록 섹션 푸터 |
| [`Source/Entity.swift`](Source/Entity.swift) | 목록 항목 모델 |

## 사용 기술

UIKit, `UICollectionViewCompositionalLayout`, `UICollectionViewDiffableDataSource` 및 XIB
