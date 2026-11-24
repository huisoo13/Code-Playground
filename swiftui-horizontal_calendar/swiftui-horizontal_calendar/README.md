# SwiftUI 가로 주간 캘린더 샘플

주 단위로 좌우 스크롤하고 날짜를 선택할 수 있는 SwiftUI 캘린더 예제입니다.

## 구성

- **주간 페이지** — 선택한 날짜를 기준으로 이전 주, 현재 주, 다음 주를 만들고 한 번에 한 주를 표시합니다.
- **연속 스크롤** — 스크롤이 양 끝에 닿으면 필요한 주를 추가하고 반대편의 주를 제거한 뒤 스크롤 위치를 보정합니다.
- **날짜 선택** — 날짜 셀을 탭하면 바인딩을 갱신합니다. 스크롤로 주를 바꿀 때 선택 날짜를 함께 갱신할지는 `updatesDateOnScroll`로 정합니다.

## 실행하기

Xcode에서 `swiftui-horizontal_calendar.xcodeproj`를 열어 실행합니다. 날짜를 탭하고 여러 주를 좌우로 넘겨 선택 표시와 페이지 이동을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Source/HorizontalCalendar.swift`](Source/HorizontalCalendar.swift) | 주간 페이징, 스크롤 위치 보정과 날짜 바인딩 |
| [`Source/Models.swift`](Source/Models.swift) | `Calendar`를 사용한 날짜와 주 데이터 생성 |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 선택 상태와 날짜 셀 디자인 |

## 사용 기술

SwiftUI의 `ScrollView`, `ScrollPosition`, `onScrollGeometryChange` 및 `ViewBuilder`, Foundation의 `Calendar`
