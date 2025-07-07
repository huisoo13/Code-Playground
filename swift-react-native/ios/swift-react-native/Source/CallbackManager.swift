//
//  CallbackManager.swift
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//


import Foundation
import React
import React_RCTAppDelegate


protocol CallbackManagerDelegate: AnyObject {
    func didReceiveCallback(value: String)
}

@objc(CallbackManager)
class CallbackManager: NSObject, RCTBridgeModule {
    
    weak var delegate: CallbackManagerDelegate?

    // React Native에서 확인 할 모듈 이름
    static func moduleName() -> String! {
        return "CallbackManager"
    }
    
    // 메인 스레드에서 실행
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    // JavaScript에서 호출하는 함수
    // Promise를 사용하기 위해 resolver와 rejecter를 파라미터로 추가
    @objc
    func executeCallback(_ message: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        print("React Native로부터 받은 메시지: \(message)")
        
        DispatchQueue.main.async {
            self.delegate?.didReceiveCallback(value: message)
        }
        
        // React Native에 전달
        resolve("성공적으로 Swift에 전달되었습니다.")

        // 만약 실패했다면 reject를 호출
        // let error = NSError(domain: "", code: 200, userInfo: nil)
        // reject("E_CALLBACK_ERROR", "콜백 처리 중 에러 발생", error)
    }
}
