//
//  ReactViewController.swift
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//
// 참고 링크
// https://reactnative.dev/docs/integration-with-existing-apps

import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider

class ReactViewController: UIViewController {
    
    var reactNativeFactory: RCTReactNativeFactory?
    var reactNativeFactoryDelegate: RCTReactNativeFactoryDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReactNative()
    }
    
    private func setupReactNative() {
        let delegate = ReactNativeDelegate()
        delegate.reactNativeModuleDelegate = self
        self.reactNativeFactoryDelegate = delegate
        reactNativeFactoryDelegate!.dependencyProvider = RCTAppDependencyProvider()
        reactNativeFactory = RCTReactNativeFactory(delegate: reactNativeFactoryDelegate!)
                
        view = reactNativeFactory!.rootViewFactory.view(withModuleName: "swift-react-native", initialProperties: [
            "userID": "12345678",
            "token": "secretToken"
        ])
    }
}

extension ReactViewController: ReactNativeModuleDelegate {
    func process(_ input: String) {
        print("SWIFT", #function, input)
    }
}


