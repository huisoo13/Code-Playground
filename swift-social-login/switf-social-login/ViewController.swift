//
//  ViewController.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    var platforms: [Platform] = Platform.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
        setupGestureRecognizer()
    }
    
    func setupView() {
        stackView.arrangedSubviews.enumerated().forEach { index, view in
            view.clipsToBounds = true
            view.layer.cornerRadius = view.frame.height / 2
            view.tag = index
            
            let platform = platforms[index]
            
            switch platform {
            case .apple:
                break
            case .google:
                view.layer.borderColor = UIColor.systemGray4.cgColor
                view.layer.borderWidth = 1
            case .kakao:
                break
            case .naver:
                break
            }
        }
    }
    
    func setupGestureRecognizer() {
        stackView.arrangedSubviews.forEach { view in
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapLoginButton(_:)))
            view.addGestureRecognizer(gesture)
        }
    }
    
    @objc func didTapLoginButton(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        
        let platform = platforms[index]
        Task { @MainActor in
            switch platform {
            case .apple:
                try? await AccountManager.shared.signIn(with: .apple, on: self)
            case .google:
                try? await AccountManager.shared.signIn(with: .google, on: self)
            case .kakao:
                try? await AccountManager.shared.signIn(with: .kakao)
            case .naver:
                try? await AccountManager.shared.signIn(with: .naver)
            }
        }
    }
}

