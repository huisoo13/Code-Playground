//
//  ViewFactory.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/24/25.
//

import SwiftUI

struct ViewFactory {
    @ViewBuilder
    static func view(_ path: AnyHashable) -> some View {
        switch path {
        case let path as Splash.Path:
            Splash.ViewFactory.view(path)
        case let path as Login.Path:
            Login.ViewFactory.view(path)
        case let path as Main.Path:
            Main.ViewFactory.view(path)
        default:
            fatalError("Unhandled Path type in \(#function). Please register all expected Path cases.")
        }
    }
    
    @ViewBuilder
    static func sheet(_ sheet: AnyIdentifiable, parentCoordinator: NavigationCoordinator? = nil) -> some View {
        switch sheet.value {
        case let sheet as Login.Sheet:
            Login.ViewFactory.sheet(sheet, parentCoordinator: parentCoordinator)
        default:
            fatalError("Unhandled Sheet type in \(#function). Please register all expected Sheet cases.")
        }
    }
    
    @ViewBuilder
    static func fullScreenCover(_ fullScreenCover: AnyIdentifiable, parentCoordinator: NavigationCoordinator? = nil) -> some View {
        switch fullScreenCover.value {
        default:
            fatalError("Unhandled FullScreenCover type in \(#function). Please register all expected FullScreenCover cases.")
        }
    }
    
    @ViewBuilder
    static func overCurrentContext(_ overCurrentContext: AnyIdentifiable, parentCoordinator: NavigationCoordinator? = nil) -> some View {
        switch overCurrentContext.value {
        case let overCurrentContext as Main.OverCurrentContext:
            Main.ViewFactory.overCurrentContext(overCurrentContext, parentCoordinator: parentCoordinator)
        default:
            fatalError("Unhandled OverCurrentContext type in \(#function). Please register all expected OverCurrentContext cases.")
        }
    }
}
