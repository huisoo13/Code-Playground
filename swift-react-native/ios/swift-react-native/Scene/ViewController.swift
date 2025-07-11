//
//  ViewController.swift
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//

import UIKit

class ViewController: UIViewController {
    
    var reactViewController: ReactViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let button = UIButton()
        button.setTitle("Open React Native", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addAction(UIAction { [weak self] _ in
            guard let self else { return }
            if reactViewController == nil {
                reactViewController = ReactViewController()
            }
            present(reactViewController!, animated: true)
        }, for: .touchUpInside)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
    }
}
