//
//  AccountManager+Naver.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import Foundation
import NidThirdPartyLogin

extension AccountManager.Naver {
    func initalize() {
        NidOAuth.shared.initialize()

        // NidOAuth.shared.setLoginBehavior(.app)
        // NidOAuth.shared.setLoginBehavior(.inAppBrowser)
        // NidOAuth.shared.setLoginBehavior(.appPreferredWithInAppBrowserFallback) // Default
    }
    
    func isAuthenticationRedirectURL(_ url: URL) -> Bool {
        NidOAuth.shared.handleURL(url)
    }
    
    func login() async throws {
        let accessToken = try await requestLogin()
              
        guard !accessToken.isExpired else { // 접근 토큰이 유효하다면 바로 프로필 API 호출
            return
        }

        try await getUserProfile(accessToken: accessToken)
    }
    
    func logout() {
        NidOAuth.shared.logout()
        
        // 디바이스에 저장된 정보 삭제
        KeychainManager.delete(key: "account")
    }
    
    @discardableResult
    func disconnect() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            NidOAuth.shared.disconnect { result in
                switch result {
                case .success:
                    #warning("TODO")
                    // 서버에 회원탈퇴 요청
                    // ..

                    // 디바이스에 저장된 정보 삭제
                    KeychainManager.delete(key: "account")

                    continuation.resume(returning: true)
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func requestLogin() async throws -> AccessToken {
        return try await withCheckedThrowingContinuation { continuation in
            NidOAuth.shared.requestLogin { result in
                switch result {
                case .success(let loginResult):
                    continuation.resume(returning: loginResult.accessToken)
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func getUserProfile(accessToken: AccessToken) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            NidOAuth.shared.getUserProfile(accessToken: accessToken.tokenString) { result in
                switch result {
                case .success(let profile):
                    guard let userIdentifier = profile["id"] else { return }

                    let account = Account(platform: .naver, id: userIdentifier)
                    
                    guard let data = try? JSONEncoder().encode(account),
                          let jsonString = String(data: data, encoding: .utf8) else { return }
                    
                    KeychainManager.write(key: "account", value: jsonString)

                    #warning("TODO")
                    // 서버에 accessToken 전달
                    // ..
                    
                    continuation.resume()
                case .failure(let error):
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /* 이 앱에서는 사용하지 않음
     
    /// 재인증
    func reauthenticate() {
        NidOAuth.shared.reauthenticate { result in
            switch result {
            case .success(let loginResult):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    /// 권한 요청
    func repromptPermissions() {
        NidOAuth.shared.repromptPermissions { result in
            switch result {
            case .success(let loginResult):
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    */
}
