# SwiftUI SwiftData 샘플

프로젝트와 할 일을 등록하고, SwiftData에서 두 모델의 관계와 조회 결과를 확인하는 예제입니다.

## 구성

- **프로젝트 목록** — `@Query`로 프로젝트를 최신순으로 조회합니다. 이름 중복을 검사하고 프로젝트 추가 및 스와이프 삭제를 제공합니다.
- **할 일 목록** — 프로젝트 상세에서 제목, 기한과 우선순위를 지정해 할 일을 추가합니다. 제목으로 필터링하고 마감일 순으로 정렬합니다.
- **데이터 관계** — 프로젝트와 할 일을 일대다로 연결합니다. 프로젝트를 삭제하면 `.cascade` 규칙에 따라 연결된 할 일도 함께 삭제됩니다. 디버그 화면에서 두 모델의 저장 상태를 확인할 수 있습니다.

## 실행하기

Xcode에서 `swiftui-swift-data.xcodeproj`를 열어 실행합니다. 프로젝트와 할 일을 추가한 뒤 상세 화면에서 목록을 검색하거나 디버그 화면에서 저장 결과를 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Application/swiftui_swift_dataApp.swift`](Application/swiftui_swift_dataApp.swift) | SwiftData 모델 컨테이너 설정 |
| [`Source/Model.swift`](Source/Model.swift) | `Project`와 `Task` 모델, 관계와 우선순위 |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 프로젝트 조회, 추가 및 삭제 |
| [`Scene/ProjectDetailView.swift`](Scene/ProjectDetailView.swift) | 프로젝트별 할 일 목록과 검색 |
| [`Scene/AddTaskView.swift`](Scene/AddTaskView.swift) | 할 일 추가 폼 |
| [`Source/ProjectViewModel.swift`](Source/ProjectViewModel.swift) | 할 일 필터링, 날짜 표시와 우선순위 색상 |
| [`Scene/DebugView.swift`](Scene/DebugView.swift) | 저장된 프로젝트와 할 일 목록 확인 |

## 사용 기술

SwiftUI, SwiftData의 `@Model`, `@Query`, `ModelContext` 및 `@Relationship`, Observation
