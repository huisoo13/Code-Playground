# SwiftUI Coordinator 패턴 샘플

스플래시, 로그인·가입, 메인 화면의 루트 교체와 화면 이동을 Coordinator로 관리하는 SwiftUI 예제입니다.

## Coordinator 패턴

화면 이동 요청을 Coordinator가 받아 앱의 화면 흐름을 관리하는 패턴입니다. 이 예제에서는 각 뷰가 `AppCoordinator`에 목적지를 전달하고, 컨테이너가 Coordinator의 상태를 SwiftUI의 내비게이션과 모달에 연결합니다.

## 구성

- **루트 전환** — 스플래시를 표시한 뒤 로그인으로 전환합니다. 로그인 버튼이나 가입 완료 동작은 메인 화면으로 전환하고 설정의 로그아웃 버튼은 스플래시로 돌아갑니다.
- **화면 이동** — `NavigationCoordinator`가 `NavigationPath`와 모달 상태를 관리합니다. 약관 상세는 시트로, 홈의 팝업은 현재 화면 위에 표시합니다.
- **화면 생성** — 로그인과 메인의 목적지를 각각 정의하고 `ViewFactory`에서 목적지에 맞는 뷰를 생성합니다.

## 실행하기

Xcode에서 `swiftui-coordinator-pattern.xcodeproj`를 열어 실행합니다. `SIGN UP`으로 가입 흐름과 약관 시트를, `LOGIN`으로 메인 화면 및 설정 이동과 팝업을 확인할 수 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Source/Coordinator/Core/AppCoordinator.swift`](Source/Coordinator/Core/AppCoordinator.swift) | 앱 루트 변경과 활성 Coordinator 탐색 |
| [`Source/Coordinator/Core/NavigationCoordinator.swift`](Source/Coordinator/Core/NavigationCoordinator.swift) | 목적지 추가, 모달 상태 변경과 화면 닫기 |
| [`Source/Coordinator/Core/NavigationContainer.swift`](Source/Coordinator/Core/NavigationContainer.swift) | `NavigationStack`, 시트 및 오버레이 상태 연결 |
| [`Source/Coordinator/ViewFactory/ViewFactory.swift`](Source/Coordinator/ViewFactory/ViewFactory.swift) | 목적지 타입에 따른 뷰 생성 분기 |
| [`Source/Coordinator/ViewFactory/ViewFactory+Login.swift`](Source/Coordinator/ViewFactory/ViewFactory+Login.swift) | 로그인·가입 흐름의 목적지와 화면 |
| [`Source/Coordinator/ViewFactory/ViewFactory+Main.swift`](Source/Coordinator/ViewFactory/ViewFactory+Main.swift) | 메인 흐름의 목적지와 화면 |

## 사용 기술

SwiftUI의 `NavigationStack`과 `NavigationPath`, Observation의 `@Observable`, 환경 객체 주입
