# UIKit Coordinator 패턴 샘플

UIKit에서 상세 화면 이동과 모달 흐름을 Coordinator로 관리하는 예제입니다.

## Coordinator 패턴

화면을 생성하고 다음 목적지로 이동하는 책임을 별도의 Coordinator 객체에 맡기는 패턴입니다. 이 예제에서는 화면이 버튼 입력을 전달하고, `AppCoordinator`와 `ChildCoordinator`가 각각 자신의 화면 흐름을 관리합니다.

## 구성

- **앱 시작** — `SceneDelegate`가 `UINavigationController`와 `AppCoordinator`를 만들고 메인 화면을 표시합니다.
- **상세 화면 이동** — 메인 화면이 이동을 요청하면 `AppCoordinator`가 상세 화면을 생성하고 내비게이션 스택에 추가합니다.
- **모달 흐름** — `ChildCoordinator`가 별도의 내비게이션 컨트롤러를 모달로 표시합니다. 자식 흐름이 끝나면 부모의 `childCoordinators`에서 제거합니다.

## 실행하기

Xcode에서 `swift-coordinator.xcodeproj`를 열어 실행한 뒤 메인 화면에서 push와 모달 전환을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Application/SceneDelegate.swift`](Application/SceneDelegate.swift) | 앱의 내비게이션 컨트롤러와 Coordinator 초기화 |
| [`Common/Coordinator.swift`](Common/Coordinator.swift) | Coordinator 프로토콜과 공통 화면 전환 메서드 |
| [`Coordinator/AppCoordinator.swift`](Coordinator/AppCoordinator.swift) | 메인 화면, 상세 화면, 자식 Coordinator 연결 |
| [`Coordinator/ChildCoordinator.swift`](Coordinator/ChildCoordinator.swift) | 모달 흐름 시작과 종료 |
| [`Scene/Main/ViewController.swift`](Scene/Main/ViewController.swift) | 화면 전환을 요청하는 버튼 액션 |

## 사용 기술

Swift, UIKit, `UINavigationController`, Storyboard 및 XIB
