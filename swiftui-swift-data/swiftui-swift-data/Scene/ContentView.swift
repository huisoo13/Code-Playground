//
//  ContentView.swift
//  swiftui-swift-data
//
//  Created by Huisoo on 7/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // 데이터베이스 작업을 위한 modelContext
    @Environment(\.modelContext) private var modelContext
    
    // 모든 Project 데이터를 생성일 역순으로 가져옵니다.
    @Query(sort: \Project.creationDate, order: .reverse) private var projects: [Project]
    
    // 새 프로젝트 추가 Alert를 제어하기 위한 UI 상태값
    @State private var isShowingAddProjectAlert = false
    @State private var newProjectName = ""

    // DebugView sheet 제어용 상태값
    @State private var isShowingDebugView = false

    var body: some View {
        NavigationStack {
            Group {
                // 프로젝트가 하나도 없을 때 안내 문구를 보여줍니다.
                if projects.isEmpty {
                    ContentUnavailableView(
                        "프로젝트가 없습니다",
                        systemImage: "folder.badge.plus",
                        description: Text("새로운 프로젝트를 추가하여 시작하세요.")
                    )
                } else {
                    // 프로젝트 목록을 리스트로 보여줍니다.
                    List {
                        ForEach(projects) { project in
                            // 각 프로젝트를 탭하면 ProjectDetailView로 이동합니다.
                            NavigationLink {
                                ProjectDetailView(project: project)
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(project.name)
                                        .font(.headline)
                                    Text("\(project.tasks.count)개의 작업")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .onDelete(perform: deleteProjects) // 스와이프하여 삭제
                    }
                }
            }
            .navigationTitle("내 프로젝트")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingDebugView = true
                    } label: {
                        Label("Debug", systemImage: "ladybug")
                    }
                }

                ToolbarItem {
                    // 새 프로젝트를 추가하는 버튼
                    Button {
                        newProjectName = "" // Alert를 띄우기 전 텍스트 초기화
                        isShowingAddProjectAlert = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            // 새 프로젝트 추가를 위한 Alert
            .alert("새 프로젝트", isPresented: $isShowingAddProjectAlert) {
                TextField("프로젝트 이름", text: $newProjectName)
                Button("취소", role: .cancel) { }
                Button("저장") {
                    addProject()
                }
            } message: {
                Text("새로운 프로젝트의 이름을 입력하세요.")
            }
            .sheet(isPresented: $isShowingDebugView) {
                DebugView()
                    .presentationDetents([.medium, .large])
            }
        }
    }
    
    // 새 프로젝트를 추가하는 함수
    private func addProject() {
        guard !newProjectName.isEmpty else { return }

        // 💡 FetchDescriptor로 중복된 이름이 있는지 확인
        let descriptor = FetchDescriptor<Project>(predicate: #Predicate { $0.name == newProjectName })
        
        do {
            let count = try modelContext.fetchCount(descriptor)
            guard count == 0 else {
                // 여기에 사용자에게 "이미 존재하는 이름입니다" 라는 Alert를 띄우는 로직 추가
                print("Error: Project name already exists.")
                return
            }
        } catch {
            print("Failed to fetch project count: \(error)")
            return
        }

        let newProject = Project(name: newProjectName)
        modelContext.insert(newProject)
    }
    // 프로젝트를 삭제하는 함수
    private func deleteProjects(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(projects[index])
        }
    }
}

#Preview {
    ContentView()
        // 프리뷰에서도 modelContainer를 설정해줘야 합니다.
        .modelContainer(for: [Project.self, Task.self], inMemory: true)
}
