# SwiftUI 커스텀 팝업 샘플

`Identifiable` 항목의 바인딩으로 현재 화면 위에 커스텀 팝업을 표시하는 SwiftUI 예제입니다.

## 구성

- **팝업 표시** — `.overScreenContext(item:)`에 항목이 전달되면 화면 위에 어두운 배경과 팝업 콘텐츠를 표시합니다.
- **팝업 닫기** — 팝업이나 배경을 탭해 항목을 `nil`로 설정합니다. 콘텐츠는 페이드 아웃이 끝날 때 제거되고, 전달한 `onDismiss`가 호출됩니다.
- **재사용** — 팝업을 여는 항목 타입과 콘텐츠를 호출하는 뷰에서 지정할 수 있습니다.

## 실행하기

Xcode에서 `swiftui-custom-popup.xcodeproj`를 열어 실행합니다. 메인 화면의 버튼을 눌러 팝업을 띄운 뒤 팝업이나 어두운 배경을 탭해 닫습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Source/FullScreenContextModifier.swift`](Source/FullScreenContextModifier.swift) | 제네릭 모디파이어와 표시 상태, 페이드 애니메이션 |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 팝업을 여는 버튼 및 항목 바인딩 |
| [`Scene/PopupView.swift`](Scene/PopupView.swift) | 예제 팝업 UI와 닫기 동작 |

## 사용 기술

SwiftUI의 `ViewModifier`, 오버레이, 상태 바인딩 및 `withAnimation`
