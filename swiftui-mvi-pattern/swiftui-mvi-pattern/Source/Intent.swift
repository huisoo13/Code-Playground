//
//  Intent.swift
//  swiftui-mvi-pattern
//
//  Created by Huisoo on 7/18/25.
//

import SwiftUI

enum KioskIntent {
    case addMenu(MenuItem)
    case increaseQuantity(OrderItem)
    case decreaseQuantity(OrderItem)
    case removeOrder(OrderItem)
    case completeOrder
    case cancelOrder
}


// Reducer 함수
func reduce(state: KioskState, intent: KioskIntent) {
    switch intent {
    case let .addMenu(menu):
        if let idx = state.orderList.firstIndex(where: { $0.menu == menu }) {
            state.orderList[idx].quantity += 1
        } else {
            let newOrder = OrderItem(id: menu.id, menu: menu, quantity: 1)
            state.orderList.append(newOrder)
        }
    case let .increaseQuantity(order):
        if let idx = state.orderList.firstIndex(where: { $0.id == order.id }) {
            state.orderList[idx].quantity += 1
        }
    case let .decreaseQuantity(order):
        if let idx = state.orderList.firstIndex(where: { $0.id == order.id }) {
            if state.orderList[idx].quantity > 1 {
                state.orderList[idx].quantity -= 1
            }
        }
    case let .removeOrder(order):
        state.orderList.removeAll { $0.id == order.id }
    case .completeOrder:
        state.isOrderCompleted = true
    case .cancelOrder:
        state.orderList = []
        state.isOrderCompleted = false
    }
}
