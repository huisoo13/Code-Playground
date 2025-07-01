//
//  Coordinator.swift
//  SwiftUI-Playground
//
//  Created by Huisoo on 6/24/25.
//

import SwiftUI

@Observable
class Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var path: NavigationPath = NavigationPath()
    var sheet: Sheet?
    var fullScreenCover: FullScreenCover?
    var overFullScreen: OverFullScreen?
    
    func push(_ destination: Page) {
        path.append(destination)
    }
    
    func present(_ destination: Sheet) {
        sheet = destination
    }
        
    func present(_ destination: FullScreenCover) {
        fullScreenCover = destination
    }
    
    func present(_ destination: OverFullScreen) {
        overFullScreen = destination
    }
    
    func dismiss() {
        switch (fullScreenCover, sheet, overFullScreen, path.isEmpty) {
        case (.some, _, _, _): // fullScreenCover가 있는 경우
            fullScreenCover = nil
        case (_, .some, _, _): // sheet가 있는 경우
            sheet = nil
        case (_, _, .some, _): // overFullScreen가 있는 경우
            overFullScreen = nil
        case (.none, .none, .none, false): // fullScreenCover와 sheet가 없고, path가 있는 경우
            path.removeLast()
        case (.none, .none, .none, true):  // 모두 없는 경우
            parentCoordinator?.dismiss()
        }
    }
}
