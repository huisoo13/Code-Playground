//
//  MessageBubbleView.swift
//  swiftui-chat-view
//
//  Created by Huisoo on 9/17/26.
//

import SwiftUI

struct MessageBubbleView: View {
    var isVisible: Bool
    var message: Message
    var namespace: Namespace.ID
    
    @Environment(\.textFieldSize) private var textFieldSize
    
    var body: some View {
        let isFit = message.isFit ?? false
        
        ZStack {
            if isVisible {
                Text(message.content)
                    .font(.body)
                    .padding(12)
                    .frame(maxWidth: isFit ? .infinity : nil, alignment: .leading)
                    .background(Color(UIColor.systemGray6))
                    .clipShape(.rect(cornerRadius: 24))
                    .matchedGeometryEffect(id: message.id, in: namespace, properties: isFit ? [.position, .size] : [.position])
                    .padding(.top, 8)
            }
        }
        .fixedSize(horizontal: isFit ? isVisible : false, vertical: true)
        .keyframeAnimator(initialValue: CGFloat.zero, trigger: isVisible) { [textFieldSize] content, progress in
            content
                .offset(y: (textFieldSize.height * 0.55) * progress)
        } keyframes: { _ in
            CubicKeyframe(1, duration: 0.15)
            CubicKeyframe(0, duration: 0.15)
        }
        .compositingGroup()
        .frame(maxWidth: textFieldSize.width, alignment: .trailing)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

#Preview {
    ContentView()
}
