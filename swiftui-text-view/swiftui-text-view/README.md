# SwiftUI 여러 줄 텍스트 입력 샘플

세로 방향 `TextField`를 감싸 고정 높이와 내용에 맞춰 늘어나는 높이를 제공하는 SwiftUI 예제입니다.

## 구성

- **고정 높이** — `.fixed`에서 지정한 높이로 입력 뷰의 공간을 잡습니다.
- **가변 높이** — `.flexible`에서 텍스트 크기에 맞춰 높이를 조정합니다. 줄 제한 값을 지정하면 레이아웃을 측정할 때 해당 줄 수까지만 반영합니다.
- **높이 측정** — 보이지 않는 `Text`로 한 줄 높이와 현재 텍스트 높이를 측정합니다. 데모의 두 입력창은 같은 문자열을 공유합니다.

## 실행하기

Xcode에서 `swiftui-text-view.xcodeproj`를 열어 실행하고 여러 줄을 입력해 두 입력창의 높이를 비교합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Source/TextView.swift`](Source/TextView.swift) | 높이 정책, 텍스트 크기 측정 및 여러 줄 입력 |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 고정 200포인트와 최대 3줄 가변 높이 비교 |

## 사용 기술

SwiftUI의 세로형 `TextField`, `GeometryReader`, `PreferenceKey` 및 `Binding`
