//
//  AccountManager+Google.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

extension AccountManager.Google {
    func isAuthenticationRedirectURL(_ url: URL) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
    }
        
    @MainActor
    func signIn() async throws {
        guard let target else { fatalError("Please set target view controller") }

        return try await withCheckedThrowingContinuation { continuation in
            GIDSignIn.sharedInstance.signIn(withPresenting: target) { result, error in
                if let error {
                    print(error.localizedDescription)
                    continuation.resume(throwing: error)
                    return
                }
                
                guard let user = result?.user,
                      let userIdentifier = user.userID,
                      let identityToken = user.idToken?.tokenString else {
                    return
                }
                
                let account = Account(platform: .google, id: userIdentifier)
                
                guard let data = try? JSONEncoder().encode(account),
                      let jsonString = String(data: data, encoding: .utf8) else { return }
                
                KeychainManager.write(key: "account", value: jsonString)

                #warning("TODO")
                // 서버에 identityToken 전달
                // ..
                
                continuation.resume()
            }
        }
    }
    
    func signOut() {
        // Google Sign out
        GIDSignIn.sharedInstance.signOut()
        
        // 디바이스에 저장된 정보 삭제
        KeychainManager.delete(key: "account")
    }
    
    @discardableResult
    func disconnect() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            GIDSignIn.sharedInstance.disconnect { error in
                if let error {
                    continuation.resume(throwing: error)
                } else {
                    #warning("TODO")
                    // 서버에 회원탈퇴 요청
                    // ..
                    
                    // 디바이스에 저장된 정보 삭제
                    KeychainManager.delete(key: "account")
                    
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    /* 이 앱에서는 사용하지 않음
    GIDSignIn.sharedInstance.currentUser
     
    /// 복구
    func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            // Check if `user` exists; otherwise, do something with `error`
            guard let user else {
                // Inspect error
                return
            }
            
        }
    }
     */
}
