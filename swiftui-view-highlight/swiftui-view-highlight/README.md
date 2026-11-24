# SwiftUI 뷰 강조 샘플

버튼이나 텍스트를 선택하면 주변을 어둡게 하고 선택한 뷰만 드러내는 SwiftUI 예제입니다.

## 구성

- **대상 등록** — `HighlightView`가 식별자, 위치, 스타일 및 닫기 콜백을 `PreferenceKey`로 상위 뷰에 전달합니다.
- **강조 효과** — `HighlightContainer`가 선택한 대상의 위치에 맞춰 원형 또는 모서리가 둥근 사각형 영역을 오버레이에서 잘라 냅니다.
- **닫기 처리** — 어두운 배경을 탭하면 현재 강조를 닫고 해당 대상의 콜백을 호출합니다. 프로필 버튼을 강조한 뒤에는 콜백에서 설정 버튼을 다음 대상으로 선택합니다.

## 실행하기

Xcode에서 `swiftui-view-highlight.xcodeproj`를 열어 실행합니다. `프로필 보기`를 탭하고 배경을 눌러 강조가 `설정`으로 이어지는 동작을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 프로필 버튼, 설정 버튼과 텍스트 강조 예제 |
| [`Source/HighlightContainer.swift`](Source/HighlightContainer.swift) | 대상 좌표 수집, 오버레이 합성 및 닫기 콜백 |

## 사용 기술

SwiftUI의 `GeometryReader`, `PreferenceKey`, `Binding`, `blendMode(.destinationOut)` 및 `compositingGroup`
