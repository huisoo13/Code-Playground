//
//  ViewController.swift
//  swift-strategy-pattern
//
//  Created by 정희수 on 4/21/25.
//

import UIKit

class ViewController: UIViewController {

    private var errorHandlingLevel: ErrorHandlingLevel = .all
    private var errorHandler: ErrorHandlingStrategy?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        foo()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        bar()
    }

    func foo() {
        switch errorHandlingLevel {
        case .all:
            errorHandler = CompositeErrorHandler([AlertErrorHandler(target: self), LoggingErrorHandler()])
        case .alert:
            errorHandler = AlertErrorHandler(target: self)
        case .logging:
            errorHandler = LoggingErrorHandler()
        case .none:
            errorHandler = nil
        }
    }
    
    func bar() {
        guard false else {
            errorHandler?.handle(.unknown)
            return
        }
        
        // ...
    }
}

