//
//  AddTaskView.swift
//  swiftui-swift-data
//
//  Created by Huisoo on 7/16/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    let project: Project
    @State private var title: String = ""
    @State private var dueDate: Date = .now
    @State private var priority: Priority = .medium
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("작업 이름", text: $title)
                DatePicker("마감일", selection: $dueDate, displayedComponents: .date)
                Picker("우선순위", selection: $priority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.description)
                    }
                }
            }
            .navigationTitle("새로운 작업 추가")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("취소") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) { Button("저장") { addTask() } }
            }
        }
    }
    
    private func addTask() {
        let newTask = Task(title: title, dueDate: dueDate, priority: priority)
        newTask.project = project // 관계 설정
        modelContext.insert(newTask)
        dismiss()
    }
}
