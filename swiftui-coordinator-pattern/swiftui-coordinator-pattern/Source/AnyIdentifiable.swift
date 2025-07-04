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
