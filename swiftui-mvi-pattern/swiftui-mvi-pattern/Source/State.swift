//
//  State.swift
//  swiftui-mvi-pattern
//
//  Created by Huisoo on 7/18/25.
//

import SwiftUI

// @Observable State 정의
@Observable
class KioskState {
    var menuList: [MenuItem] = [
        .init(id: 1, name: "햄버거", price: 5000),
        .init(id: 2, name: "감자튀김", price: 2000),
        .init(id: 3, name: "콜라", price: 1500)
    ]
    var orderList: [OrderItem] = []
    var isOrderCompleted: Bool = false
    
    var totalPrice: Int {
        orderList.reduce(0) { $0 + $1.menu.price * $1.quantity }
    }
}

