//
//  ViewController.swift
//  swift-mvvm-pattern
//
//  Created by Huisoo on 7/31/25.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ViewModel = ViewModel(model: Model())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        observeViewModel()
    }

    private func setupView() {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.backgroundColor = .systemBlue
        
        button.addAction(UIAction(handler: { _ in
            self.viewModel.updateNumber(self.viewModel.model.value.number + 1)
        }), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func observeViewModel() {
        viewModel.model.addObserver(on: self) { model in
            print(model)
        }
    }
}

