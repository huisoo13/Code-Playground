/*
    Created by Huisoo on 2025-06-20
*/

import UIKit

class PopupViewController: UIViewController {
    enum PopupPresentationStyle {
        case none
        case fade
        case translate(_ from: Direction)
        
        enum Direction {
            case top
            case bottom
            case left
            case right
        }
    }
    
    var presentationStyle: PopupPresentationStyle = .fade
    var blurEffectStyle: UIBlurEffect.Style? = nil
    var duration: TimeInterval = 0.3
    var presentAnimationOption: UIView.AnimationOptions = .curveEaseOut
    var dismissAnimationOption: UIView.AnimationOptions = .curveEaseIn

    private let backgroundColor: UIColor = .black.withAlphaComponent(0.3)
    private let backgroundView: UIView = UIView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        config()
        
        modalPresentationStyle = .overCurrentContext
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        config()
    }
    
    private func config() {
        backgroundView.frame = UIScreen.main.bounds
        backgroundView.backgroundColor = backgroundColor

        view.isHidden = true
        view.backgroundColor = .clear
        
        setupBlurView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let presentingViewController = presentingViewController else { return }
        presentingViewController.view.addSubview(backgroundView)

        presentAnimation()
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissAnimation {
            self.backgroundView.removeFromSuperview()
            self.view.isHidden = true

            super.dismiss(animated: false, completion: completion)
        }
    }
    
    private func setupBlurView() {
        if let blurEffectStyle {
            backgroundView.subviews.forEach {
                if $0.accessibilityIdentifier == "blurView" {
                    $0.removeFromSuperview()
                }
            }
            
            let blurEffect = UIBlurEffect.init(style: blurEffectStyle)
            
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = backgroundView.bounds
            blurView.accessibilityIdentifier = "blurView"
            backgroundView.insertSubview(blurView, at: .zero)
        }
    }
}

// MARK: - Animation
extension PopupViewController {
    fileprivate func presentAnimation() {
        view.isHidden = false
        
        switch presentationStyle {
        case .none:
            break
        case .fade:
            fadeIn()
        case .translate(let direction):
            transitionIn(direction)
        }
    }
    
    fileprivate func dismissAnimation(completion: @escaping () -> Void) {
        switch presentationStyle {
        case .none:
            break
        case .fade:
            fadeOut(completion: completion)
        case .translate(let direction):
            transitionOut(direction, completion: completion)
        }
    }
    
    // Fade
    private func fadeIn() {
        backgroundView.alpha = 0
        
        view.isHidden = false
        view.alpha = 0
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: duration, delay: 0, options: presentAnimationOption) {
            self.backgroundView.alpha = 1
            
            self.view.alpha = 1
            self.view.layoutIfNeeded()
        } completion: { _ in
            // ...
        }
    }
    
    private func fadeOut(completion: @escaping () -> Void) {
        UIView.animate(withDuration: duration, delay: 0, options: dismissAnimationOption) {
            self.backgroundView.alpha = 0
            self.view.alpha = 0
        } completion: { _ in
            completion()
        }
    }

    // Transition
    private func transitionIn(_ direction: PopupPresentationStyle.Direction = .bottom) {
        backgroundView.alpha = 0

        let bounds = UIScreen.main.bounds
        switch direction {
        case .top:
            view.transform = CGAffineTransform(translationX: 0, y: -bounds.height)
        case .bottom:
            view.transform = CGAffineTransform(translationX: 0, y: bounds.height)
        case .left:
            view.transform = CGAffineTransform(translationX: -bounds.width, y: 0)
        case .right:
            view.transform = CGAffineTransform(translationX: bounds.width, y: 0)
        }
        
        view.layoutIfNeeded()
        UIView.animate(withDuration: duration, delay: 0, options: presentAnimationOption) {
            self.backgroundView.alpha = 1
            self.backgroundView.backgroundColor = self.backgroundColor

            self.view.transform = .identity
            self.view.layoutIfNeeded()
        } completion: { _ in
            // ...
        }
    }
    
    private func transitionOut(_ direction: PopupPresentationStyle.Direction = .bottom, completion: @escaping () -> Void) {
        view.transform = .identity
        UIView.animate(withDuration: duration, delay: 0, options: dismissAnimationOption) {
            self.backgroundView.alpha = 0

            let bounds = UIScreen.main.bounds
            switch direction {
            case .top:
                self.view.transform = CGAffineTransform(translationX: 0, y: -bounds.height)
            case .bottom:
                self.view.transform = CGAffineTransform(translationX: 0, y: bounds.height)
            case .left:
                self.view.transform = CGAffineTransform(translationX: -bounds.width, y: 0)
            case .right:
                self.view.transform = CGAffineTransform(translationX: bounds.width, y: 0)
            }
        } completion: { _ in
            completion()
        }
    }
}
