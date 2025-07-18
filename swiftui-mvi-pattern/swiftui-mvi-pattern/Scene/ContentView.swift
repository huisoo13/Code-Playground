//
//  ContentView.swift
//  swiftui-mvi-pattern
//
//  Created by Huisoo on 7/18/25.
//

import SwiftUI

struct ContentView: View {
    @Bindable var state = KioskState()
    
    var body: some View {
        VStack(spacing: 24) {
            Text("키오스크")
                .font(.largeTitle)
            
            // 메뉴 목록
            VStack(alignment: .leading, spacing: 8) {
                Text("메뉴").font(.headline)
                ForEach(state.menuList) { menu in
                    HStack {
                        Text("\(menu.name) (\(menu.price)원)")
                        Spacer()
                        Button("추가") {
                            reduce(state: state, intent: .addMenu(menu))
                        }
                        .disabled(state.isOrderCompleted)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // 주문 내역
            VStack(alignment: .leading, spacing: 8) {
                Text("주문 내역").font(.headline)
                if state.orderList.isEmpty {
                    Text("주문한 메뉴가 없습니다.").foregroundColor(.gray)
                } else {
                    ForEach(state.orderList) { order in
                        HStack {
                            Text("\(order.menu.name) x\(order.quantity)")
                            Spacer()
                            Button("+") {
                                reduce(state: state, intent: .increaseQuantity(order))
                            }
                            .disabled(state.isOrderCompleted)
                            Button("-") {
                                reduce(state: state, intent: .decreaseQuantity(order))
                            }
                            .disabled(state.isOrderCompleted || order.quantity == 1)
                            Button("삭제") {
                                reduce(state: state, intent: .removeOrder(order))
                            }
                            .disabled(state.isOrderCompleted)
                        }
                    }
                }
                Divider()
                HStack {
                    Text("합계: \(state.totalPrice)원")
                    Spacer()
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // 주문 버튼
            if !state.isOrderCompleted {
                HStack {
                    Button("주문하기") {
                        reduce(state: state, intent: .completeOrder)
                    }
                    .disabled(state.orderList.isEmpty)
                    Button("취소") {
                        reduce(state: state, intent: .cancelOrder)
                    }
                    .foregroundColor(.red)
                    .disabled(state.orderList.isEmpty)
                }
            } else {
                VStack(spacing: 12) {
                    Text("주문이 완료되었습니다! 🥳")
                        .foregroundColor(.green)
                    Button("새 주문") {
                        reduce(state: state, intent: .cancelOrder)
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
