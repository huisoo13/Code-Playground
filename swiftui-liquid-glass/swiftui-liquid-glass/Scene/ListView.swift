//
//  ListView.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/22/25.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        ZStack {
            Color
                .gray
                .ignoresSafeArea(.all)
//                .clear
//                .overlay(
//                    Image("bg_img")
//                        .resizable()
//                        .scaledToFill()
//                        .ignoresSafeArea(.all)
//                    
//                )
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(0..<20) { _ in
                        Text("String")
                            .frame(height: 64)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.black)
                            .glassEffect(.clear.interactive(), in: .rect(cornerRadius: 16))
                            .padding(.horizontal, 16)


                    }
                }
            }
        }
    }
}

#Preview {
    ListView()
}

