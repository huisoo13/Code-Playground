//
//  ImageBackgroundView.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/22/25.
//

import SwiftUI

struct ImageBackgroundView: View {
    @State private var isExpanded = false
    @State private var isAnimating = false

    var body: some View {
        ZStack(alignment: .bottom) {
            Color
                .clear
                .overlay(
                    Image("bg_img")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)

                )

            HStack {
                VerticalMenuButton(isExpanded: $isExpanded, isAnimating: $isAnimating)
                Spacer()
            }
            .padding(32)
            
            HStack {
                Spacer()
                RadialMenuButton(isExpanded: $isExpanded, isAnimating: $isAnimating)
            }
            .padding(32)
        }
    }
}

#Preview {
    ImageBackgroundView()
}
