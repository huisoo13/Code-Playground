//
//  ChatView.swift
//  swiftui-chat-view
//
//  Created by Huisoo on 9/17/26.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var textFieldSize: CGSize = .zero
}

struct ChatView: View {
    @State private var messages: [Message] = Message.placeholderMessages
    @State private var currentMessage: Message = .init(content: "")
    @State private var textFieldSize: CGSize = .zero
    
    @Namespace private var namespace
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(messages) { message in
                    let isVisible = currentMessage.id != message.id
                    MessageBubbleView(isVisible: isVisible,
                                      message: message,
                                      namespace: namespace)

                }
            }
            .padding(16)
        }
        .defaultScrollAnchor(.bottom)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            bottomBar()
        }
        .environment(\.textFieldSize, textFieldSize)
    }
    
    @ViewBuilder
    private func bottomBar() -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            TextField("Type a message", text: $currentMessage.content, axis: .vertical)
                .font(.body)
                .lineLimit(6)
                .padding(16)
                .glassEffect(.regular.interactive(), in: .rect(cornerRadius: 24))
                .overlay(alignment: .topLeading, content: {
                    ForEach(messages) {
                        if currentMessage.id == $0.id {
                            temporaryMessageTransitionSource(currentMessage)
                        }

                    }
                })
                .onGeometryChange(for: CGSize.self) {
                    $0.size
                } action: { newValue in
                    textFieldSize = newValue
                }
            
            Button {
                sendMessage()
            } label: {
                Image(systemName: "arrow.up")
                    .font(.body)
                    .fontWeight(.semibold)
                    .frame(width: 24, height: 40)
            }
            .buttonStyle(.glassProminent)
            .buttonBorderShape(.circle)
            .disabled(currentMessage.content.isEmpty)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
    
    @ViewBuilder
    private func temporaryMessageTransitionSource(_ message: Message) -> some View {
        let isFit = message.isFit ?? false

        Text(message.content)
            .font(.body)
            .padding(12)
            .frame(maxWidth: isFit ? .infinity : nil, alignment: .leading)
            .background(Color(UIColor.systemGray6))
            .clipShape(.rect(cornerRadius: 24))
            .matchedGeometryEffect(id: message.id, in: namespace, properties: isFit ? [.position, .size] : [.position])
    }
    
    private func sendMessage() {
        let textWidth = calculateTextSize(text: currentMessage.content, fontStyle: .body).width
        let contentPadding: CGFloat = 32
        let isFit = textWidth < (textFieldSize.width - contentPadding)
        messages.append(currentMessage)
        
        DispatchQueue.main.async {
            let reference = currentMessage
            
            /// Animating From TextField to message block using matched Geometry effect
            withAnimation(animation, completionCriteria: .removed) {
                currentMessage = .init(content: "")
            } completion: {
                if let index = messages.firstIndex(where:  { $0.id == reference.id }) {
                    messages[index].isFit = nil
                }
            }
        }
    }
    
    private func calculateTextSize(text: String, fontStyle: UIFont.TextStyle) -> CGSize {
        NSString(string: text).size(withAttributes: [
            .font: UIFont.preferredFont(forTextStyle: fontStyle)
        ])
    }
    
    private var animation: Animation {
        .interpolatingSpring(duration: 0.3, bounce: 0, initialVelocity: 0)
    }
}

#Preview {
    ContentView()
}
