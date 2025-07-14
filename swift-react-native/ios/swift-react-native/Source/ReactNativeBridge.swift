//
//  ReactNativeBridge.swift
//  swift-react-native
//
//  Created by Huisoo on 7/10/25.
//

import Foundation
import React
import React_RCTAppDelegate

class ReactNativeBridge: NSObject, RCTBridgeDelegate {
    
    private var bridge: RCTBridge?
    private var module: ReactNativeModule?
    
    func setupBridge() {
        self.bridge = RCTBridge(delegate: self, launchOptions: nil)
        self.module = self.bridge?.module(for: ReactNativeModule.self) as? ReactNativeModule
    }
    
    // JS 번들의 위치를 제공합니다.
    func sourceURL(for bridge: RCTBridge) -> URL? {
        #if DEBUG
        return RCTBundleURLProvider.sharedSettings().jsBundleURL(forBundleRoot: "ReactNativeBridge") // 실행할 JS 파일 이름
        #else
        return Bundle.main.url(forResource: "main", withExtension: "jsbundle")
        #endif
    }
    
    // JS 함수를 호출하고 결과를 받는 함수
    func call(_ method: String, parameters: [String: Any]) {
        // 브릿지가 로드되었는지 확인
        guard let _ = self.bridge else {
            return
        }
        
        // JS 모듈의 함수를 호출합니다.
        module?.call(method, parameters: parameters)
    }
}
