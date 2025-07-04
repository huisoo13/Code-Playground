//
//  ViewFactory+Main.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

enum Main {
    enum Path: HashableIdentifiable, PathProtocol {
        case home
        case setting
        case profile
        case termsDetail
    }
    
    enum Sheet: StringIdentifiable, SheetProtocol { }
    
    enum FullScreenCover: StringIdentifiable, FullScreenCoverProtocol { }
    
    enum OverCurrentContext: StringIdentifiable, OverCurrentContextProtocol {
        case popup
    }
    
    struct ViewFactory {
        @ViewBuilder
        static func view(_ path: Path) -> some View {
            switch path {
            case .home:
                HomeView()
            case .setting:
                SettingView()
            case .profile:
                ProfileView(type: .update)
            case .termsDetail:
                TermsDetailView()
            }
        }
        
        @ViewBuilder
        static func sheet(_ sheet: Sheet, parentCoordinator: NavigationCoordinator? = nil) -> some View { }
        
        @ViewBuilder
        static func fullScreenCover(_ fullScreenCover: FullScreenCover, parentCoordinator: NavigationCoordinator? = nil) -> some View { }
        
        @ViewBuilder
        static func overCurrentContext(_ overCurrentContext: OverCurrentContext, parentCoordinator: NavigationCoordinator? = nil) -> some View {
            switch overCurrentContext {
            case .popup:
                PopupView()
            }
        }
    }
}

