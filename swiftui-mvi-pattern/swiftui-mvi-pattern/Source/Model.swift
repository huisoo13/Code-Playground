//
//  Model.swift
//  swiftui-mvi-pattern
//
//  Created by Huisoo on 7/18/25.
//

import SwiftUI

// 메뉴와 주문 모델
struct MenuItem: Identifiable, Equatable {
    let id: Int
    let name: String
    let price: Int
}
struct OrderItem: Identifiable, Equatable {
    let id: Int
    let menu: MenuItem
    var quantity: Int
}
