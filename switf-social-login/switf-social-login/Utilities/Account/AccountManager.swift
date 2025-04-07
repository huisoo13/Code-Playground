//
//  AccountManager.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import UIKit

@MainActor
class AccountManager {
    static let shared = AccountManager()
    private init() {}
    
    // MARK: - Properties
    
    var hasAccount: Bool {
        self.currentAccount != nil
    }
    
    var currentPlatform: Platform? {
        self.currentAccount?.platform
    }
    
    var currentAccount: Account? {
        guard let jsonString = KeychainManager.read(key: "account"),
              let data = jsonString.data(using: .utf8),
              let account = try? JSONDecoder().decode(Account.self, from: data) else { return nil }

        return account
    }
    
    // MARK: - Initial
    /**
     AppDelegate.swift
     application(_:didFinishLaunchingWithOptions:)
     */
    func setup() {
        Kakao().initalize()
        Naver().initalize()
    }
    
    /**
     SceneDelegate.swift
     scene(_:openURLContexts:)
     */
    func isAuthenticationRedirectURL(_ url: URL) -> Bool {
        Google().isAuthenticationRedirectURL(url)
        || Kakao().isAuthenticationRedirectURL(url)
        || Naver().isAuthenticationRedirectURL(url)
    }
    
    // MARK: - Sign
    
    func signIn(with platform: Platform, on target: UIViewController? = nil) async throws {
        switch platform {
        case .apple:
            try await Apple(target: target).signIn()
        case .google:
            try await Google(target: target).signIn()
        case .kakao:
            try await Kakao().login()
        case .naver:
            try await Naver().login()
        }
    }
    
    func signOut(with platform: Platform) async throws {
        switch platform {
        case .apple:
            Apple().signOut()
        case .google:
            Google().signOut()
        case .kakao:
            try await Kakao().logout()
        case .naver:
            Naver().logout()
        }
    }
    
    func disconnect(with platform: Platform) async throws {
        switch platform {
        case .apple:
            try await Apple().disconnect()
        case .google:
            try await Google().disconnect()
        case .kakao:
            try await Kakao().unlink()
        case .naver:
            try await Naver().disconnect()
        }
    }
    
    // MARK: - Subclass
    
    class Apple: NSObject {
        var continuation: CheckedContinuation<Void, Error>?
        
        var target: UIViewController?
        init(target: UIViewController? = nil) {
            self.target = target
        }
    }
    
    class Google {
        var target: UIViewController?
        init(target: UIViewController? = nil) {
            self.target = target
        }
    }
    
    class Kakao { }
    class Naver { }
}
