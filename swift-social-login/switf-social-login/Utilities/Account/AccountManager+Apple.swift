//
//  AccountManager+Apple.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import AuthenticationServices

extension AccountManager.Apple {
    func signIn() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            // request.nonce = ""
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
    
    func signOut() {
        // 디바이스에 저장된 정보 삭제
        KeychainManager.delete(key: "account")
    }
    
    @discardableResult
    func disconnect() async throws -> Bool {
        #warning("TODO")
        // 서버에 회원탈퇴 요청
        // ..

        // 디바이스에 저장된 정보 삭제
        KeychainManager.delete(key: "account")
        
        return true
    }
    
    /* 이 앱에서는 사용하지 않음
    func checkAuthorizationStatus(using id: String) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: id) { state, error in
            if error != nil {
                return
            }
            
            switch state {
            case .authorized:
                print("authorized")
            case .notFound:
                print("not found")
            case .revoked:
                print("revoked")
            default:
                break
            }
        }
    }
    
    func addObserverForCredentialRevokedNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(revokeAuthorizationCredential), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)
    }
    
    @objc func revokeAuthorizationCredential() {
        /// 디바이스에 저장된 정보 삭제
        /// 서버에 Refresh Token 전달 또는 서버에 저장된 Refresh Token 사용하여 Apple REST API 사용하여 Revoke
    }
     */
}

extension AccountManager.Apple: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
        self.continuation?.resume(throwing: error)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credentials = authorization.credential as? ASAuthorizationAppleIDCredential,
              // let authorizationCode = credentials.authorizationCode,
              // let authorizationCodeString = String(data: authorizationCode, encoding: .utf8),
                let identityToken = credentials.identityToken,
              let identityTokenString = String(data: identityToken, encoding: .utf8) else {
            return
        }
        
        let account = Account(platform: .apple, id: credentials.user)
        guard let data = try? JSONEncoder().encode(account),
              let jsonString = String(data: data, encoding: .utf8) else { return }
        
        KeychainManager.write(key: "account", value: jsonString)

        #warning("TODO")
        // 서버에 identityToken 전달
        // ..
        
        self.continuation?.resume()
    }
}

extension AccountManager.Apple: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let target else { fatalError("Please set target view controller") }

        return target.view.window!
    }
}

