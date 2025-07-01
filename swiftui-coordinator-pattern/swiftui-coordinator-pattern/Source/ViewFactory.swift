//
//  ViewFactory.swift
//  SwiftUI-Playground
//
//  Created by Huisoo on 6/24/25.
//

import SwiftUI

enum Page: Hashable {
    case one
    case two
    case three(_ text: String)
}

enum Sheet: String, Identifiable {
    var id: String { self.rawValue }
    
    case sheet
}

enum FullScreenCover: String, Identifiable {
    var id: String { self.rawValue }
    
    case fullScreenCover
}

enum OverFullScreen: String, Identifiable {
    var id: String { self.rawValue }
    
    case overFullScreen
}

struct ViewFactory {
    @ViewBuilder
    static func view(_ page: Page) -> some View {
        switch page {
        case .one:
            OneView()
        case .two:
            TwoView()
        case .three(let text):
            ThreeView(text: text)
                .background(.red)
        }
    }
    
    @ViewBuilder
    static func view(_ sheet: Sheet, parentCoordinator: Coordinator? = nil) -> some View {
        switch sheet {
        case .sheet:
            NavigationContainer(parentCoordinator: parentCoordinator) {
                TwoView()
                    .presentationDetents([.height(300)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
    
    @ViewBuilder
    static func view(_ fullScreenCover: FullScreenCover, parentCoordinator: Coordinator? = nil) -> some View {
        switch fullScreenCover {
        case .fullScreenCover:
            TwoView()
            // .presentationBackground(.clear) // 배경 지우는 방법
        }
    }
    
    @ViewBuilder
    static func view(_ overFullScreen: OverFullScreen, parentCoordinator: Coordinator? = nil) -> some View {
        switch overFullScreen {
        case .overFullScreen:
            TwoView()
        }
    }
}
