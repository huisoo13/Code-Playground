//
//  Profile.swift
//  switf-social-login
//
//  Created by 정희수 on 4/7/25.
//

import Foundation

struct Profile: Codable {
    var nickname: String
    var birthDate: String
    var birthTime: String?
    var isLunarCalendar: Bool
    var gender: Gender
    var isMarried: Bool
    var hasChildren: Bool
}

enum Gender: String, Codable {
    case male
    case female
}
