//
//  AppDelegate.swift
//  swift-universal-link
//
//  Created by 정희수 on 4/29/25.
//

import UIKit

class UniversalLinkManager {
    
    enum UniversalLinkSource {
        case connectionOptions(UIScene.ConnectionOptions)
        case userActivity(NSUserActivity)
        case urlString(String)
    }
    
    static let shared = UniversalLinkManager()
    private init() {}
    
    private var type: UniversalLinkType? = nil
    
    // MARK: - Public
    
    /**
     Universal Link 변환 후 저장하는 함수
     */
    func prepareUniversalLink(from source: UniversalLinkSource) {
        switch source {
        case .connectionOptions(let connectionOptions):
            parseUniversalLink(connectionOptions)
        case .userActivity(let userActivity):
            parseUniversalLink(userActivity)
        case .urlString(let urlString):
            convertToUniversalLinkType(urlString)
        }
    }
    
    /**
     Universal Link 변환 후 실행까지 하는 함수
     */
    func handleUniversalLink(from source: UniversalLinkSource) {
        prepareUniversalLink(from: source)
        executeUniversalLinkIfNeeded()
    }

    /**
     앱이 첫 실행 된 후 Universal Link로 접근했는지 확인하고 저장하는 함수
     */
    func restoreDeferredUniversalLinkIfNeeded() async {
        // 지연된 딥링크는 첫 실행 시에만 적용
        let didCheckDeferredUniversalLink = UserDefaults.standard.bool(forKey: "didCheckDeferredUniversalLink")
        guard !didCheckDeferredUniversalLink else {
            return
        }
        
        UserDefaults.standard.set(true, forKey: "didCheckDeferredUniversalLink")
        
        #warning("방법 선택하기")
        // 방법 1: 클립보드에 저장된 Device Fingerprinting 데이터를 서버에서 검증 후 사용하는 방법
        if let string = UIPasteboard.general.string {
        #warning("서버 호출")
            // 서버에 전송하여 검증 후 Response 값 사용
            let urlString = "Response 에서 얻은 urlString"
            
            convertToUniversalLinkType(urlString)
        } else {
            print(#function, "clipboard content not found")
        }
        
        // 방법 2: 브라우저와 같은 양식의 Device Finger printing 데이터를 서버에 전달해 사용자를 추적하는 방법
        #warning("서버 호출")
        let urlString = "Response 에서 얻은 urlString"
        
        convertToUniversalLinkType(urlString)
    }
    
    /**
     저장된 Universal Link를 실행하는 함수
     */
    func executeUniversalLinkIfNeeded() {
        guard let type else {
            // 처리할 type이 없는 경우
            return
        }

        // 초기화
        self.type = nil

        switch type {
        case .home:
            break
        case .today:
            break
        case .contents(let id):
            break
        }
    }
        
    // MARK: - Private
    
    /**
     scene(_:willConnectTo:options:)
     앱이 설치 되어 있고 앱이 실행 중이 아닐 때 Universal Link로 앱이 실행 된 경우 사용
     */
    private func parseUniversalLink(_ connectionOptions: UIScene.ConnectionOptions) {
        guard let userActivity = connectionOptions.userActivities.first,
              userActivity.activityType == NSUserActivityTypeBrowsingWeb else {
            print(#function, "This is not a valid universal link launch.")
            return
        }
        
        parseUniversalLink(userActivity)
    }
    
    /**
     scene(_:continue:)
     앱이 실행 중이거나 메모리에 남아 있을때 Universal Link로 앱이 열린 경우 사용
     */
    private func parseUniversalLink(_ userActivity: NSUserActivity) {
        guard let urlString = userActivity.webpageURL?.absoluteString else {
            print(#function, " Invalid universal link")
            return
        }

        convertToUniversalLinkType(urlString)
    }
    
    /**
     앱 내부에서 별도로 url을 획득한 경우 사용
     */
    private func convertToUniversalLinkType(_ urlString: String) {
        let type = UniversalLinkType(urlString: urlString)
        self.type = type
    }
}
