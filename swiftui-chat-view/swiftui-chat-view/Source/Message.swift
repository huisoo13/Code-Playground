//
//  Message.swift
//  swiftui-chat-view
//
//  Created by Huisoo on 9/17/26.
//

import SwiftUI

struct Message: Identifiable {
    var id: String
    var content: String
    var isFit: Bool?
    
    init(content: String) {
        self.id = UUID().uuidString
        self.content = content
        self.isFit = nil
    }
    
    static var placeholderMessages: [Message] {
        [
            .init(content: "Hey, I'm iJutine"),
            .init(content: "THis is Chat Bubble Transition Using SwiftUI!")
        ]
    }
}
