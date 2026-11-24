# SwiftUI 미니 음악 플레이어 샘플

탭 바 위의 미니 플레이어가 전체 화면으로 확장되고 스와이프로 다시 접히는 전환을 보여주는 SwiftUI 예제입니다.

## 구성

- **미니 플레이어** — 탭 바의 하단 액세서리에 예제 곡 정보와 재생 아이콘을 표시합니다.
- **확장 전환** — 미니 플레이어를 탭하면 기존 위치와 크기를 기준으로 오버레이를 확장하고, 아트워크와 재생 컨트롤 UI를 표시합니다.
- **닫기 제스처** — 확장 화면을 아래로 끌면 거리와 속도를 반영해 닫거나 원래 위치로 복귀합니다. 재생 버튼과 슬라이더는 화면 전환을 시연하기 위한 자리표시자입니다.

## 실행하기

Xcode에서 `swiftui-music-player.xcodeproj`를 열어 실행합니다. 하단 플레이어를 탭해 확장한 뒤 아래로 드래그해 접고, 홈 탭을 스크롤해 탭 바 축소 동작을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 탭 바 및 하단 액세서리와 확장 오버레이 전환 |
| [`Scene/View/PlayerContainer.swift`](Scene/View/PlayerContainer.swift) | 플레이어 배치, 확장·축소 상태와 드래그 처리 |
| [`Scene/View/MiniPlayer.swift`](Scene/View/MiniPlayer.swift) | 미니 플레이어 UI |
| [`Scene/View/ExpandedPlayer.swift`](Scene/View/ExpandedPlayer.swift) | 확장 플레이어 UI |
| [`Source/AppTab.swift`](Source/AppTab.swift) | 탭 이름과 SF Symbols |

## 사용 기술

SwiftUI, Liquid Glass, `tabViewBottomAccessory`, `matchedGeometryEffect` 및 `UIGestureRecognizerRepresentable`
