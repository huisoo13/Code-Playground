//
//  ViewController.swift
//  swift-custom-tab-bar
//
//  Created by 정희수 on 5/21/25.
//

import UIKit

protocol RootViewDelegate {
    func rootViewController(_ viewController: UIViewController)
}

class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet var buttons: [UIButton]!

    var delegate: RootViewDelegate?
    
    var viewControllers: [UIViewController] = []
    var selectedIndex: Int = 0

    private var isTransitioning: Bool = false
    
    private let selectColor: UIColor? = .label
    private let deselectColor: UIColor? = .secondaryLabel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        setupTabBarView()
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        
    }
}

extension ViewController {
    fileprivate func setupViewControllers() {
        viewControllers.append(OneViewController.nib())
        viewControllers.append(TwoViewController.nib())
        viewControllers.append(ThreeViewController.nib())
        viewControllers.append(FourViewController.nib())
    }

    fileprivate func setupTabBarView() {
        buttons.enumerated().forEach { i, button in
            button.tag = i
            button.tintColor = .clear
            button.addTarget(self, action: #selector(touchUpInsideTheButton(_:)), for: .touchUpInside)
            button.isSelected = false
            
            var configuration = UIButton.Configuration.plain()
            configuration.baseForegroundColor = deselectColor
            configuration.imagePlacement = .top
            configuration.imagePadding = 5
            configuration.buttonSize = .mini
            
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: 10)

            switch button.tag {
            case 0:
                configuration.attributedTitle = AttributedString("TAB 1", attributes: container)
                
                button.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .normal)
                button.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .selected)
            case 1:
                configuration.attributedTitle = AttributedString("TAB 2", attributes: container)

                button.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .normal)
                button.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .selected)
            case 2:
                configuration.attributedTitle = AttributedString("TAB 3", attributes: container)

                button.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .normal)
                button.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .selected)
            case 3:
                configuration.attributedTitle = AttributedString("TAB 4", attributes: container)

                button.setImage(UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .normal)
                button.setImage(UIImage(systemName: "circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14, weight: .thin)), for: .selected)
            default:
                break
            }
            
            button.configuration = configuration
            
            if i == selectedIndex { touchUpInsideTheButton(button) }
        }
    }
    
    // 최초 viewDidLoad 에서 한번 함수를 실행시키기
    @objc func touchUpInsideTheButton(_ sender: UIButton) {
        if sender.isSelected || isTransitioning { return }
        
        isTransitioning = true

        // 버튼 상태 변경
        self.buttons.forEach { button in
            button.isSelected = sender.tag == button.tag
            button.configuration?.baseForegroundColor = sender.tag == button.tag ? selectColor : deselectColor
            let image = sender.tag == button.tag ? button.image(for: .selected) : button.image(for: .normal)
            button.imageView?.setSymbolImage(image ?? UIImage(), contentTransition: .automatic)
            button.alpha = sender.tag == button.tag ? 1 : 0.5
        }
        
        // 이전에 선택되어 있던 버튼의 index 저장
        let previousIndex = selectedIndex
        
        // 새로운 버튼의 index 저장
        selectedIndex = sender.tag
                                
        let from = viewControllers[previousIndex]
        let to = viewControllers[selectedIndex]

        transition(from: from, to: to, isLeftToRight: previousIndex < selectedIndex)

        // 애니메이션
        animation(sender)

        // 할당한 viewController에 rootViewController 전달
        delegate?.rootViewController(self)
    }
    
    private func transition(from: UIViewController, to: UIViewController, isLeftToRight: Bool) {
        if from == to {
            addChild(to)
            delegate = to as? any RootViewDelegate
            contentView.addSubview(to.view)

            to.view.frame = contentView.bounds
            to.didMove(toParent: self)
            
            self.isTransitioning = false
            return
        }
                
        addChild(to)
        delegate = to as? any RootViewDelegate
        contentView.addSubview(to.view)
        
        // 위치 조정
        to.view.frame = self.contentView.bounds
        to.view.frame.origin.x = isLeftToRight ? self.contentView.bounds.width : -self.contentView.bounds.width
        transition(from: from, to: to, duration: 0.3, options: .beginFromCurrentState) {
            to.view.frame = from.view.frame
            from.view.frame.origin.x = isLeftToRight ? -from.view.frame.width : from.view.frame.width
        } completion: { _ in
            // 이전의 viewController를 해제
            from.willMove(toParent: nil)
            from.view.removeFromSuperview()
            from.removeFromParent()
            // 새로 선택한 버튼에 해당하는 viewController 할당
            to.didMove(toParent: self)
            
            self.isTransitioning = false
        }
    }
    
    private func animation(_ view: UIView) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0, animations: {
                view.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
            
            }, completion: { _ in
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
                    view.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
                })
            })
        }
    }
}
