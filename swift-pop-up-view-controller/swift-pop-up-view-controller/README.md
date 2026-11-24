# UIKit 팝업 뷰 컨트롤러 샘플

현재 화면 위에 모달을 표시하고 나타날 때와 사라질 때의 애니메이션을 바꿔 보는 UIKit 예제입니다.

## 구성

- **표시 방식** — `PopupViewController`는 애니메이션 없음, 페이드, 상하좌우 슬라이드 방식을 제공합니다.
- **배경 처리** — 팝업을 열 때 기존 화면 위에 어두운 배경 뷰를 추가하고, 팝업을 닫을 때 제거합니다.
- **예제 화면** — 버튼 다섯 개로 페이드와 네 방향 슬라이드를 선택할 수 있습니다.

## 실행하기

Xcode에서 `swift-pop-up-view-controller.xcodeproj`를 열어 실행한 뒤 각 버튼으로 팝업을 표시합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Source/PopupViewController.swift`](Source/PopupViewController.swift) | `overCurrentContext` 모달과 표시·닫기 애니메이션 |
| [`Scene/ViewController.swift`](Scene/ViewController.swift) | 버튼별 팝업 표시 방식 설정 |
| [`Scene/CustomViewController.swift`](Scene/CustomViewController.swift) | 팝업 화면과 터치 시 닫기 동작 |
| [`Scene/CustomViewController.xib`](Scene/CustomViewController.xib) | 팝업 콘텐츠 레이아웃 |

## 사용 기술

Swift, UIKit, `UIView` 애니메이션 및 XIB
