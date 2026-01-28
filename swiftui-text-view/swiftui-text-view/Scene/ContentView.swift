//
//  ContentView.swift
//  swiftui-text-view
//
//  Created by Huisoo on 1/28/26.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Text("Fixed height")
            
            TextView("Placehoder", text: $text, option: .fixed(200))
                .padding()
                .background(.black.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Spacer()
            
            Text("Flexible height")
            TextView(
                "Placehoder",
                text: $text,
                prompt: Text("Placehoder Text")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.red),
                option: .flexible(3)
            )
            .padding()
            .background(.black.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .font(.system(size: 14, weight: .medium))
        .lineSpacing(10)
        .padding()
    }
}

#Preview {
    ContentView()
}
