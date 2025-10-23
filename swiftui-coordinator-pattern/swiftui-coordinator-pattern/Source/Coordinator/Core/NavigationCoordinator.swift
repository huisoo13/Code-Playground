//
//  Coordinator.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 6/24/25.
//

import SwiftUI

@MainActor @Observable
class NavigationCoordinator {
    weak var parentCoordinator: NavigationCoordinator?
    
    var path: NavigationPath = NavigationPath()
    var sheet: AnyIdentifiable?
    var fullScreenCover: AnyIdentifiable?
    var overCurrentContext: AnyIdentifiable?
    
    func push(_ destination: AnyHashable) {
        guard destination is PathProtocol else {
            fatalError("Only values conforming to both Hashable and Path protocols are allowed for \(#function).")
        }

        path.append(destination)
    }
    
    func present(_ destination: any Identifiable) {
        switch destination {
        case is SheetProtocol:
            sheet = AnyIdentifiable(destination)
        case is FullScreenCoverProtocol:
            fullScreenCover = AnyIdentifiable(destination)
        case is OverCurrentContextProtocol:
            overCurrentContext = AnyIdentifiable(destination)
        default:
            fatalError("Only values conforming to both Identifiable and Sheet, FullScreenCover, or OverCurrentContext protocols are allowed for \(#function).")
        }
    }
    
    func dismiss() {
        switch (fullScreenCover, sheet, overCurrentContext, path.isEmpty) {
        case (.some, _, _, _):  // fullScreenCover가 있는 경우
            fullScreenCover = nil
        case (_, .some, _, _):  // sheet가 있는 경우
            sheet = nil
        case (_, _, .some, _):  // overFullScreen가 있는 경우
            overCurrentContext = nil
        case (.none, .none, .none, false):  // fullScreenCover와 sheet가 없고, path가 있는 경우
            path.removeLast()
        case (.none, .none, .none, true):   // 모두 없는 경우
            parentCoordinator?.dismiss()
        }
    }
    
    func dismissAll() {
        switch (fullScreenCover, sheet, overCurrentContext, path.isEmpty) {
        case (.some, _, _, _):  // fullScreenCover가 있는 경우
            fullScreenCover = nil
            fallthrough
        case (_, .some, _, _):  // sheet가 있는 경우
            sheet = nil
            fallthrough
        case (_, _, .some, _):  // overFullScreen가 있는 경우
            overCurrentContext = nil
            fallthrough
        case (.none, .none, .none, false):  // fullScreenCover와 sheet가 없고, path가 있는 경우
            path = NavigationPath()
            fallthrough
        case (.none, .none, .none, true):   // 모두 없는 경우
            parentCoordinator?.dismissAll()
        }
    }
}

