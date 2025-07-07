//
//  ReactNativeDelegate.swift
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//

import React
import React_RCTAppDelegate
import ReactAppDependencyProvider

class ReactNativeDelegate: RCTDefaultReactNativeFactoryDelegate {
    
    weak var callbackManagerDelegate: CallbackManagerDelegate?

    override func sourceURL(for bridge: RCTBridge) -> URL? {
        self.bundleURL()
    }

    override func bundleURL() -> URL? {
        #if DEBUG
        RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "index")
        #else
        Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }

    override func extraModules(for bridge: RCTBridge) -> [RCTBridgeModule] {
        let callbackManager = CallbackManager()
        callbackManager.delegate = callbackManagerDelegate
        return [callbackManager]
    }
}
