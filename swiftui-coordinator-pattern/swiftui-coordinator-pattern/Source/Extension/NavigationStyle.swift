//
//  NavigationStyle.swift
//  SwiftUI-Playground
//
//  Created by Huisoo on 6/23/25.
//

import SwiftUI

extension View {
    func navigationStyle(_ title: String, leftToolBarItems: [ToolBarItemStyle] = [], rightToolBarItems: [ToolBarItemStyle] = []) -> some View {
        let font = Font.system(size: 16, weight: .medium, design: .default)
        
        return self.navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(font)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    HStack(spacing: 0) {
                        ForEach(leftToolBarItems, id: \.self) { style in
                            ToolBarItemView(style: style)
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        ForEach(rightToolBarItems, id: \.self) { style in
                            ToolBarItemView(style: style)
                        }
                    }
                }
            }
    }
}

enum ToolBarItemStyle: Hashable {
    case back
    case close
    case custom(imageName: String, action: () -> Void)

    static func == (lhs: ToolBarItemStyle, rhs: ToolBarItemStyle) -> Bool {
        switch (lhs, rhs) {
        case (.back, .back),
            (.close, .close):
            return true
        case let (.custom(imageName1, _), .custom(imageName2, _)):
            return imageName1 == imageName2
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .back: hasher.combine("back")
        case .close: hasher.combine("close")
        case let .custom(imageName, _): hasher.combine(imageName)
        }
    }
}

private struct ToolBarItemView: View {
    @Environment(NavigationCoordinator.self) var coordinator
    // @Environment(\.dismiss) var dismiss // Coordinator 미사용 시

    let style: ToolBarItemStyle

    var body: some View {
        switch style {
        case .back:
            Button {
                coordinator.dismiss() // pop or dismiss
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }

        case .close:
            Button {
                coordinator.dismiss() // pop or dismiss
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(.black)
            }

        case .custom(let imageName, let action):
            Button {
                action()
            } label: {
                Image(systemName: imageName)
                    .foregroundStyle(.black)
            }
        }
    }
}
