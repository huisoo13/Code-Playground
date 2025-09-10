//
//  Protocol.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/3/25.
//

import Foundation

// MARK: - ID 자동 설정을 위한 Protocol

protocol HashableIdentifiable: Hashable, Identifiable where ID == AnyHashable { }
extension HashableIdentifiable {
    var id: AnyHashable { AnyHashable(self) }

    // case에 Closure가 포함 된 경우를 위해 두 값을 id 값으로 비교하는 코드 추가
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

protocol StringIdentifiable: Identifiable { }
extension StringIdentifiable {
    var id: String { String(describing: self) }
}

// MARK: 타입 비교를 위한 Protocol

protocol PathProtocol { }
protocol SheetProtocol { }
protocol FullScreenCoverProtocol { }
protocol OverCurrentContextProtocol { }

/**
 위 Protocol에 Hashable 또는 Identifiable을 상속 후 사용 할 수 있지만
 타입 비교 시 any 를 붙이지 않기 위해서 빈 Protocol로 사용
 */
