//
//  ProjectViewModel.swift
//  swiftui-swift-data
//
//  Created by Huisoo on 7/16/25.
//


import SwiftUI

@Observable
class ProjectViewModel {
    var searchTerm: String = ""
    var isShowingAddTaskSheet: Bool = false
    
    // 검색어(searchTerm)를 기반으로 할 일 목록을 필터링하여 보여줌
    func filteredTasks(_ tasks: [Task]) -> [Task] {
        let filtered = searchTerm.isEmpty
            ? tasks
            : tasks.filter { $0.title.localizedCaseInsensitiveContains(searchTerm) }
        
        // 정렬 로직은 불변성을 위해 여기에 유지하는 것이 좋습니다.
        return filtered.sorted { $0.dueDate < $1.dueDate }
    }
    
    // 남은 기한을 보기 좋게 문자열로 변환
    func formattedDueDate(from date: Date) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return "오늘"
        } else if calendar.isDateInTomorrow(date) {
            return "내일"
        } else {
            let startOfToday = calendar.startOfDay(for: .now) // 오늘 날짜의 시작
            let startOfTargetDate = calendar.startOfDay(for: date) // 대상 날짜의 시작

            let components = calendar.dateComponents([.day], from: startOfToday, to: startOfTargetDate)
            if let days = components.day, days > 0 {
                return "\(days)일 남음"
            } else {
                return "기한 지남"
            }
        }
    }
    
    // 우선순위에 따라 색상을 반환
    func colorForPriority(_ priority: Priority) -> Color {
        switch priority {
        case .low: .gray
        case .medium: .blue
        case .high: .red
        }
    }
}
