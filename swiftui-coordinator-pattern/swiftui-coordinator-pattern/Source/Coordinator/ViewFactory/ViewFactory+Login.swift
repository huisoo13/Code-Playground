//
//  ViewFactory+FeatureB.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

enum Login {
    struct Root: StringIdentifiable, RootProtocol { let id: AnyHashable }
    static let root = Root(id: "Login")

    enum Path: HashableIdentifiable, PathProtocol {
        case login
        case terms
        case profile
    }
    
    enum Sheet: StringIdentifiable, SheetProtocol {
        case termsDetail
    }
    
    enum FullScreenCover: StringIdentifiable, FullScreenCoverProtocol { }
    
    enum OverCurrentContext: StringIdentifiable, OverCurrentContextProtocol { }
    
    struct ViewFactory {
        @ViewBuilder
        static func root() -> some View {
            NavigationContainer {
                LoginView()
            }
        }
        
        @ViewBuilder
        static func view(_ path: Path) -> some View {
            switch path {
            case .login:
                LoginView()
            case .terms:
                TermsView()
            case .profile:
                ProfileView(type: .create)
            }
        }
        
        @ViewBuilder
        static func sheet(_ sheet: Sheet, parentCoordinator: NavigationCoordinator? = nil) -> some View {
            switch sheet {
            case .termsDetail:
                NavigationContainer(parentCoordinator: parentCoordinator) {
                    TermsDetailView()
                }
            }
        }
        
        @ViewBuilder
        static func fullScreenCover(_ fullScreenCover: FullScreenCover, parentCoordinator: NavigationCoordinator? = nil) -> some View { }
        
        @ViewBuilder
        static func overCurrentContext(_ overCurrentContext: OverCurrentContext, parentCoordinator: NavigationCoordinator? = nil) -> some View { }
    }
}

