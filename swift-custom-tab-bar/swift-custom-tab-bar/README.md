# UIKit 커스텀 탭 바 샘플

네 개의 자식 뷰 컨트롤러를 커스텀 탭 바에서 전환하는 UIKit 예제입니다.

## 구성

- **탭 버튼** — 선택 상태에 따라 버튼의 색상과 SF Symbol을 변경하고 스프링 애니메이션을 적용합니다.
- **화면 전환** — 탭 인덱스의 이동 방향에 맞춰 새 화면을 좌우로 슬라이드하고, 전환이 끝나면 이전 자식 뷰 컨트롤러를 제거합니다.
- **자식 화면** — 각 탭의 뷰 컨트롤러를 XIB에서 불러오고 `RootViewDelegate`로 루트 컨트롤러를 전달합니다.

## 실행하기

Xcode에서 `swift-custom-tab-bar.xcodeproj`를 열어 실행한 뒤 `TAB 1`부터 `TAB 4`까지 선택해 화면 전환을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/TabBar/ViewController.swift`](Scene/TabBar/ViewController.swift) | 탭 선택, 자식 컨트롤러 관리, 전환 애니메이션 |
| [`Scene/TabBar/Base.lproj/Main.storyboard`](Scene/TabBar/Base.lproj/Main.storyboard) | 탭 바와 콘텐츠 영역 배치 |
| [`Scene/ViewController/OneViewController.swift`](Scene/ViewController/OneViewController.swift) | 첫 번째 탭의 예제 화면 |
| [`Scene/ViewController/FourViewController.swift`](Scene/ViewController/FourViewController.swift) | 네 번째 탭의 예제 화면 |
| [`Source/Storyboarded.swift`](Source/Storyboarded.swift) | Storyboard 및 XIB 인스턴스 생성 유틸리티 |

## 사용 기술

Swift, UIKit, View Controller Containment, Auto Layout 및 SF Symbols
