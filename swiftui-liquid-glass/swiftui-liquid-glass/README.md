# SwiftUI Liquid Glass 샘플

Liquid Glass를 SwiftUI의 목록, 탭 바, 메뉴 버튼에 적용해 보는 iOS 예제입니다.

## 구성

- **목록 효과** — 스크롤 목록의 각 행에 터치에 반응하는 투명한 유리 효과를 적용합니다.
- **탭 바** — 아래로 스크롤하면 탭 바가 축소되며, 탭 바 하단 액세서리와 검색 역할의 탭도 포함합니다.
- **확장 메뉴** — 이미지 배경 위에서 수직 메뉴와 방사형 메뉴를 표시합니다. 메뉴 버튼에 Glass ID를 지정해 펼치고 접을 때 모양이 이어지도록 합니다.

## 실행하기

Xcode에서 `swiftui-liquid-glass.xcodeproj`를 열고 iOS 26 이상을 대상으로 실행합니다. 목록을 스크롤해 탭 바 동작을 확인하고 이미지 탭에서 메뉴를 펼칩니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 탭, 검색과 하단 액세서리 구성 |
| [`Scene/ListView.swift`](Scene/ListView.swift) | 유리 효과를 적용한 스크롤 목록 |
| [`Scene/ImageBackgroundView.swift`](Scene/ImageBackgroundView.swift) | 이미지 위 수직·방사형 메뉴 배치 |
| [`Source/VerticalMenuButton.swift`](Source/VerticalMenuButton.swift) | 수직 메뉴 전환 |
| [`Source/RadialMenuButton.swift`](Source/RadialMenuButton.swift) | 방사형 메뉴 전환 |
| [`Source/ButtonType.swift`](Source/ButtonType.swift) | 메뉴 항목 속성과 배치 위치 |

## 사용 기술

SwiftUI, Liquid Glass의 `glassEffect`, `GlassEffectContainer`와 `glassEffectID`, `tabBarMinimizeBehavior` 및 `tabViewBottomAccessory`
