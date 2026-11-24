# SwiftUI 스포트라이트 온보딩 샘플

화면의 특정 요소를 순서대로 강조하고 각 요소의 설명을 팝오버로 표시하는 SwiftUI 온보딩 예제입니다.

## 구성

- **강조 대상 등록** — `highlight` 모디파이어에서 뷰의 위치와 크기, 순서, 제목, 설명 및 마스크 모양을 등록합니다.
- **스포트라이트** — 현재 대상 모양만큼 어두운 오버레이를 잘라 내고, 대상 위치에 따라 설명 팝오버의 방향을 정합니다.
- **단계 이동** — 알림 버튼, 검색창, 추가 버튼 순서로 강조합니다. `Next`로 다음 단계에 이동하고 `Skip` 또는 `Finish`로 종료합니다.

## 실행하기

Xcode에서 `swiftui-spotlight-onboarding.xcodeproj`를 열어 iOS 27 이상을 대상으로 실행하고 `Show View`를 누릅니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 예제 화면과 세 가지 온보딩 대상 |
| [`Source/Highlight.swift`](Source/Highlight.swift) | 대상 좌표 수집, 역마스크, 팝오버 및 단계 관리 |

## 사용 기술

SwiftUI의 `onGeometryChange`, `fullScreenCover`, `popover` 및 역마스크, Liquid Glass
