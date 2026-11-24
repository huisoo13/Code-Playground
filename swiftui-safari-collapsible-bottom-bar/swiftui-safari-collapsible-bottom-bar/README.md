# SwiftUI Safari 스타일 접이식 하단 바 샘플

스크롤 제스처에 따라 주소 입력창과 툴바가 접히거나 펼쳐지는 효과를 SwiftUI로 시연하는 예제입니다.

## 구성

- **확장·축소 상태** — 콘텐츠 영역을 드래그하고 손을 뗄 때의 세로 속도로 하단 바의 상태를 전환합니다. 축소된 바를 탭하면 다시 펼칠 수 있습니다.
- **주소 입력창** — 입력창의 포커스와 안전 영역을 고려해 하단 바를 배치하고, Liquid Glass를 적용합니다.
- **툴바 버튼** — 뒤로, 앞으로, 공유, 북마크, 탭 버튼을 표시합니다. 버튼 액션은 자리표시자입니다.

## 실행하기

Xcode에서 `swiftui-safari-collapsible-bottom-bar.xcodeproj`를 열어 실행합니다. 콘텐츠 영역을 위로 쓸어 올려 하단 바를 접고, 바를 탭하거나 반대 방향으로 쓸어 펼칩니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 스크롤 영역, 제스처 종료 처리 및 하단 바 상태 |
| [`Source/SafariBottomBar.swift`](Source/SafariBottomBar.swift) | 축소·확장 레이아웃, 주소 입력창, 액션 빌더 |

## 사용 기술

SwiftUI의 `ScrollView`, `DragGesture`, `FocusState`, `safeAreaInset`, Liquid Glass 및 Result Builder
