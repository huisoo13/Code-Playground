//
//  ViewController.swift
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//

import UIKit

class ViewController: UIViewController {
        
    let bridge = ReactNativeBridge()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setTitle("Open React Native", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.blue, for: .highlighted)
        button.addAction(UIAction { [weak self] _ in
            
            let reactViewController = ReactViewController()
            self?.present(reactViewController, animated: true)
            
//            self?.bridge.call("multiply", parameters: ["a": 5, "b": 7])
            
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        bridge.setupBridge()
    }
}
