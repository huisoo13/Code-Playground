//
//  AppTab.swift
//  swiftui-music-player
//
//  Created by Huisoo on 11/16/26.
//

import SwiftUI

enum AppTab: String {
    case home = "Home"
    case new = "New"
    case radio = "Radio"
    case library = "Library"
    case search = "Search"
    
    var symbol: String {
        switch self {
        case .home: return "house"
        case .new: return "square.grid.2x2.fill"
        case .radio: return "dot.radiowaves.left.and.right"
        case .library: return "music.note.square.stack"
        case .search: return "magnifyingglass"
        }
    }
    
    @ViewBuilder
    var label: some View {
        Group {
            Text(self.rawValue)
            Image(systemName: self.symbol)
        }
    }
}
