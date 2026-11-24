# SwiftUI 애니메이션 시작 화면 샘플

앱 시작 시 로고를 애니메이션으로 표시하고, 온보딩 완료 상태에 따라 안내 화면이나 메인 화면으로 이어지는 SwiftUI 예제입니다.

## 구성

- **시스템 시작 화면** — `Info.plist`의 `UILaunchScreen` 설정이 시작 이미지와 배경색을 지정합니다.
- **첫 실행 흐름** — 앱이 시작된 뒤 전체 화면 스플래시에서 로고가 줄어들고 온보딩이 나타납니다. Apple 로그인 버튼의 완료 콜백이 온보딩 완료 여부를 저장합니다.
- **이후 실행 흐름** — 온보딩이 완료된 상태에서는 로고를 축소했다가 확장하면서 메인 화면을 드러냅니다.

## 실행하기

Xcode에서 `swiftui-animated-launch-screen.xcodeproj`를 열어 실행합니다. 저장된 온보딩 상태에 따라 스플래시 전환이 달라집니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Info.plist`](Info.plist) | 시스템 시작 화면의 색상과 이미지 설정 |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 온보딩 화면 및 `AppStorage` 완료 상태 |
| [`Source/LaunchScreen.swift`](Source/LaunchScreen.swift) | `splashSreen` 모디파이어와 두 가지 전환 애니메이션 |

## 사용 기술

SwiftUI의 `fullScreenCover`, `AnyLayout`, 이미지 마스크 및 `AppStorage`, AuthenticationServices
