//
//  DebugView.swift
//  swiftui-swift-data
//
//  Created by Huisoo on 7/16/25.
//

import SwiftUI
import SwiftData

struct DebugView: View {
    // 모든 Project와 Task 데이터를 가져옵니다.
    @Query(sort: \Project.creationDate, order: .reverse) private var projects: [Project]
    @Query(sort: \Task.dueDate) private var tasks: [Task]

    var body: some View {
        NavigationStack {
            List {
                Section("Projects (\(projects.count)개)") {
                    if projects.isEmpty {
                        Text("저장된 프로젝트가 없습니다.")
                    } else {
                        ForEach(projects) { project in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(project.name)
                                    .font(.headline)
                                
                                Text("생성일: \(project.creationDate.formatted(date: .numeric, time: .shortened))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                Text("작업 수: \(project.tasks.count)개")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section("Tasks (\(tasks.count)개)") {
                    if tasks.isEmpty {
                        Text("저장된 작업이 없습니다.")
                    } else {
                        ForEach(tasks) { task in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(task.title)
                                    .font(.headline)
                                
                                Text("마감일: \(task.dueDate.formatted(date: .numeric, time: .shortened))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                
                                // 연결된 프로젝트 이름을 보여주어 관계 확인
                                Text("소속 프로젝트: \(task.project?.name ?? "없음")")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("디버그 정보")
        }
    }
}

// MARK: - Preview
#Preview {
    DebugView()
        .modelContainer(for: [Project.self, Task.self], inMemory: true)
}
