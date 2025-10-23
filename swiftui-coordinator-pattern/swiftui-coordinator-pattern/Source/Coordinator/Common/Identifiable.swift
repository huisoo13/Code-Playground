//
//  AnyIdentifiable.swift
//  swiftui-coordinator-pattern
//
//  Created by Huisoo on 7/2/25.
//

import Foundation

struct AnyIdentifiable: Identifiable, Equatable, Hashable {
    
    let value: any Identifiable     // 타입이 지워진 실제 값
    let id: AnyHashable             // 타입이 지워진 ID 값
    
    init<I: Identifiable>(_ identifiable: I) {
        self.value = identifiable
        self.id = AnyHashable(identifiable.id)
    }
    
    // MARK: - Protocol Conformance
    
    static func == (lhs: AnyIdentifiable, rhs: AnyIdentifiable) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - ID 자동 설정을 위한 Protocol

protocol HashableIdentifiable: Hashable, Identifiable where ID == AnyHashable { }
extension HashableIdentifiable {
    var id: AnyHashable { String(describing: self) }

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
