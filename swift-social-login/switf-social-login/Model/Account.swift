//
//  Account.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import Foundation

struct Account: Codable {
    var platform: Platform
    var id: String
}

enum Platform: String, Codable, CaseIterable {
    case apple
    case google
    case kakao
    case naver
}
