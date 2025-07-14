//
//  ReactNativeDelegate.swift
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//

import React
import React_RCTAppDelegate

protocol ReactNativeModuleDelegate: AnyObject {
    func process(_ input: String)
}

@objc(ReactNativeModule)
class ReactNativeModule: RCTEventEmitter {
        
    weak var delegate: ReactNativeModuleDelegate?
    
    // EventEmitter로 보낼 이벤트
    override func supportedEvents() -> [String]! {
        return ["onTimerTick", "call"]
    }
    
    // 메인 스레드에서 실행
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    // JavaScript에서 호출하는 함수
    // Promise를 사용하기 위해 resolver와 rejecter를 파라미터로 추가
    @objc func callback(_ input: String, resolver resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
        print("SWIFT \(input)")
        
        DispatchQueue.main.async {
            self.delegate?.process(input)
        }
        
        // React Native에 전달
        resolve("SUCCESS")
        
        // 만약 실패했다면 reject를 호출
        // let error = NSError(domain: "", code: 200, userInfo: nil)
        // reject("E_CALLBACK_ERROR", "콜백 처리 중 에러 발생", error)
    }
    
    @objc func timer() {
        DispatchQueue.main.async {
            print("SWIFT", #function, "START")
            var count: Int = 0
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                count += 1
                
                self.sendEvent(withName: "onTimerTick", body: ["count": count])
                print("SWIFT", #function, count)
                
                if count >= 5 {
                    timer.invalidate()
                    print("SWIFT", #function, "END")
                }
            }
        }
    }
    
    @objc func call(_ method: String, parameters: [String: Any]) {
        var body: [String: Any] = ["method": method]
        body.merge(parameters) { (_, new) in new }
        sendEvent(withName: "call", body: body)
    }
}
