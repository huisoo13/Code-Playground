//
//  ButtonType.swift
//  swiftui-liquid-glass
//
//  Created by Huisoo on 7/22/25.
//

import SwiftUI

enum ButtonType: String, Identifiable, CaseIterable {
    var id: String { String(describing: self.rawValue ) }
    
    case home, write, chat, email
    
    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .write:
            return "pencil"
        case .chat:
            return "bubble"
        case .email:
            return "at"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .home: .blue
        case .write: .cyan
        case .chat: .mint
        case .email: .green
        }
    }
    
    var label: String {
        self.rawValue.capitalized
    }
    
    var delay: CGFloat {
        switch self {
        case .home:
            return 0
        case .write:
            return 0.1
        case .chat:
            return 0.2
        case .email:
            return 0.3
        }
    }
    
    func offset(expanded: Bool) -> CGSize {
        guard expanded else {
            return .zero
        }
        
        switch self {
        case .home:
            return offset(atIndex: 0, expanded: expanded)
        case .write:
            return offset(atIndex: 1, expanded: expanded)
        case .chat:
            return offset(atIndex: 2, expanded: expanded)
        case .email:
            return offset(atIndex: 3, expanded: expanded)
        }
    }
    
    private func offset(atIndex index: Int, expanded: Bool) -> CGSize {
        let radius: CGFloat = 120
        let startAngleDeg = -180.0
        let step = 90.0 / Double(4 - 1)
        
        let angleDeg = startAngleDeg + (Double(index) * step)
        let angleRad = angleDeg * .pi / 180
        
        let x = cos(angleRad) * radius
        let y = sin(angleRad) * radius
        
        return CGSize(width: x, height: y)
    }
}
