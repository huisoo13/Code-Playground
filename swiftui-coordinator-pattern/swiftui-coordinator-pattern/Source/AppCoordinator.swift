//
//  AppCoordinator.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

@MainActor @Observable
class AppCoordinator {
    enum Root {
        case splash
        case login
        case main
    }

    var root: Root = .splash
    
    func set(_ root: Root) {
        withAnimation {
            self.root = root
        }
    }
}
