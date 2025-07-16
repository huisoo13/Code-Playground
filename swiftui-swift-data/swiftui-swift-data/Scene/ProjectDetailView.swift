//
//  ProjectDetailView.swift
//  swiftui-swift-data
//
//  Created by Huisoo on 7/16/25.
//


import SwiftUI
import SwiftData

struct ProjectDetailView: View {
    // 💡 1. @Bindable을 사용해 project의 이름 변경 등을 허용합니다.
    @Bindable var project: Project
    
    // 💡 2. ViewModel은 순수 UI 상태와 UI 로직만 담당하도록 축소합니다.
    @State private var viewModel = ProjectViewModel()

    // 💡 3. FetchDescriptor를 사용해 @Query를 동적으로 구성합니다.
    @Query private var tasks: [Task]

    init(project: Project) {
        self.project = project
        // 프로젝트의 ID와 일치하는 Task만 가져오도록 쿼리를 동적으로 생성합니다.
        // 검색어까지 predicate에 포함시킬 수 있습니다.
        let projectId = project.persistentModelID
        self._tasks = Query(filter: #Predicate { $0.project?.persistentModelID == projectId })
    }

    var body: some View {
        VStack {
            // UI 상태값(searchTerm)과 바인딩된 검색 바
            TextField("작업 검색...", text: $viewModel.searchTerm)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            // 프레젠테이션 로직(filteredTasks)을 통해 필터링된 목록을 표시
            List(viewModel.filteredTasks(tasks)) { task in
                HStack {
                    VStack(alignment: .leading) {
                        Text(task.title)
                            .font(.headline)
                        // 프레젠테이션 로직(formattedDueDate)을 통해 변환된 날짜 표시
                        Text(viewModel.formattedDueDate(from: task.dueDate))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    // 프레젠테이션 로직(colorForPriority)을 통해 얻은 색상으로 아이콘 표시
                    Image(systemName: "flag.fill")
                        .foregroundStyle(viewModel.colorForPriority(task.priority))
                }
            }
        }
        .navigationTitle(project.name)
        .toolbar {
            ToolbarItem {
                // UI 상태값(isShowingAddTaskSheet)을 변경하여 시트를 띄움
                Button { viewModel.isShowingAddTaskSheet = true } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingAddTaskSheet) {
            // Task를 추가하는 별도의 뷰 (코드는 생략)
            AddTaskView(project: project)
        }
    }
}
