//
//  ReactNativeDelegate.swift
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//

import React
import React_RCTAppDelegate

class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
    
    weak var reactNativeModuleDelegate: ReactNativeModuleDelegate?

    override func sourceURL(for bridge: RCTBridge) -> URL? {
        self.bundleURL()
    }

    override func bundleURL() -> URL? {
        #if DEBUG
        // 시뮬레이터 일때
        return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        
        // 실기기 일때
        // let IP = "http://12.345.67.89:8081" // Mac의 IP
        // let url = "\(IP)/index.bundle?platform=ios&dev=true&minify=false&inlineSourceMap=true"
        // return URL(string: url)
        #else
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }

    override func extraModules(for bridge: RCTBridge) -> [RCTBridgeModule] {
        let reactNativeModule = ReactNativeModule()
        reactNativeModule.delegate = reactNativeModuleDelegate
        return [reactNativeModule]
    }
    
    
}
