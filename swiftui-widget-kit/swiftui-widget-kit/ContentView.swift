//
//  ContentView.swift
//  swiftui-widget-kit
//
//  Created by Huisoo on 9/8/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("위젯 샘플 앱")
                .font(.title2).bold()
            Text("홈 화면에 위젯을 추가해서 확인하세요.")
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
