//
//  ContentView.swift
//  swiftui-view-highlight
//
//  Created by Huisoo on 10/15/25.
//

import SwiftUI

struct ContentView: View {
    @State private var highlight: AnyHashable?

    var body: some View {
        HighlightContainer($highlight) {
            VStack(spacing: 20) {
                Text("원하는 항목을 눌러 강조해보세요.")
                    .font(.headline)
                    .padding(.bottom, 40)

                // 버튼 1
                HighlightView("profileButton") {
                    Button("프로필 보기") {
                        highlight = "profileButton"
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .highlightStyle(.roundedRectengle(cornerRadius: 14, margin: 8))
                .onHighlightsDismissed {
                    withAnimation(.easeInOut) {
                        highlight = "settingsButton"
                    }
                }

                // 버튼 2
                HighlightView("settingsButton") {
                    Button("설정") {
                        highlight = "settingsButton"
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .highlightStyle(.circle(diameter: 64, margin: 4))
                
                // 텍스트 뷰도 가능
                HighlightView("infoText") {
                    Text("이 텍스트도 강조할 수 있습니다.")
                        .padding()
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                        .onTapGesture {
                            highlight = "infoText"
                        }
                }

                
                Spacer()
            }
            .padding()

        }
    }
}

#Preview {
    ContentView()
}
