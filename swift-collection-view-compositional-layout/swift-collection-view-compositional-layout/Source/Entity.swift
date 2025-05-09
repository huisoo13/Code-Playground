//
//  Entity.swift
//  swift-collection-view-compositional-layout
//
//  Created by 정희수 on 5/8/25.
//

import Foundation

struct Entity: Hashable {
    let identifier: UUID = UUID()
    
    func duplicate() -> Entity {
        let data = Entity()
        // ...
        // data.foo = self.foo
        // ...
        return data
    }
}
