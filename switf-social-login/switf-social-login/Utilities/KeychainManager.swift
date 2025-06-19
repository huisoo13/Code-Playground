//
//  KeychainHelper.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import Foundation
import Security

enum KeychainManager {
    static let service = "com.bundle.id"

    static func write(key: String, value: String) {
        if let data = value.data(using: .utf8) {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: key,
                kSecValueData: data
            ] as CFDictionary
            
            SecItemDelete(query) // 중복 방지
            SecItemAdd(query, nil)
        }
    }
    
    static func read(key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)
        if status == errSecSuccess, let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    static func delete(key: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key
        ] as CFDictionary

        SecItemDelete(query)
    }
}
