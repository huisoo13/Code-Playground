//
//  Protocol.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import Foundation

// MARK: 타입 비교를 위한 Protocol

protocol RootProtocol { }
protocol PathProtocol { }
protocol SheetProtocol { }
protocol FullScreenCoverProtocol { }
protocol OverCurrentContextProtocol { }

/**
 위 Protocol에 Hashable 또는 Identifiable을 상속 후 사용 할 수 있지만
 타입 비교 시 any 를 붙이지 않기 위해서 빈 Protocol로 사용
 */
