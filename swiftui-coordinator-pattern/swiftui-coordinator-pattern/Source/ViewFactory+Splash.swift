//
//  ViewFactory+FeatureA.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import SwiftUI

enum Splash {
    enum Path: HashableIdentifiable, PathProtocol {
        case splash
    }
    
    struct ViewFactory {
        @ViewBuilder
        static func view(_ path: Path) -> some View {
            switch path {
            case .splash:
                SplashView()
            }
        }
    }
}
