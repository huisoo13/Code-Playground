//
//  Model.swift
//  swiftui-swift-data
//
//  Created by Huisoo on 7/16/25.
//

import Foundation
import SwiftData

// 할 일의 우선순위를 나타내는 Enum
enum Priority: Int, Codable, CaseIterable {
    case low = 0, medium, high
    
    var description: String {
        switch self {
        case .low: "낮음"
        case .medium: "중간"
        case .high: "높음"
        }
    }
}

// 첫 번째 모델: 할 일 항목
@Model
final class Task {
    var title: String
    var dueDate: Date
    var priority: Priority
    
    // 관계 설정: 이 할 일이 어떤 프로젝트에 속해있는지 명시
    var project: Project?
    
    init(title: String, dueDate: Date, priority: Priority) {
        self.title = title
        self.dueDate = dueDate
        self.priority = priority
    }
}

// 두 번째 모델: 프로젝트
@Model
final class Project {
    @Attribute(.unique) var name: String
    var creationDate: Date
    
    // 프로젝트가 삭제되면 속해있는 모든 할 일도 함께 삭제
    @Relationship(deleteRule: .cascade, inverse: \Task.project)
    var tasks: [Task] = []
    
    init(name: String, creationDate: Date = .now) {
        self.name = name
        self.creationDate = creationDate
    }
}
