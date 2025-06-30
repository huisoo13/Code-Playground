//
//  PopupView.swift
//  swiftui-custom-popup
//
//  Created by Huisoo on 6/30/25.
//

import SwiftUI

struct PopupView: View {
    @Binding var item: FullScreenContext?
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Text("Hello, World!!")
            Text("Hello, World!!!")
            Text("Hello, World!!!!")
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .cornerRadius(8)
        .background()
        .padding(.horizontal, 20)
        .onTapGesture {
            item = nil
        }
    }
}

#Preview {
    @Previewable @State var item: FullScreenContext? = .fullScreenContext
    
    PopupView(item: $item)
}
