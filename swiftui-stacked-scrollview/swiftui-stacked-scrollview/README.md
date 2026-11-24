# SwiftUI 스택형 스크롤 뷰 샘플

겹쳐 보이는 배경화면 카드 묶음을 펼쳐 가로로 스크롤하는 SwiftUI 예제입니다.

## 구성

- **화면 전환** — 홈의 추가 버튼을 누르면 줌 전환으로 배경화면 팩 목록을 전체 화면에 표시합니다.
- **카드 스택** — 접힌 상태에서는 카드를 겹쳐 표시합니다. `GET`을 누르면 카드의 크기와 위치가 바뀌며 가로 스크롤 목록으로 펼쳐집니다.
- **예제 데이터** — 배경화면 이미지를 표시할 자리에 색상 에셋을 사용합니다. 각 팩 행은 자체 확장 상태를 관리합니다.

## 실행하기

Xcode에서 `swiftui-stacked-scrollview.xcodeproj`를 열어 실행합니다. `+` 버튼으로 팩 목록을 열고 `GET`을 눌러 카드를 가로로 스크롤합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/HomeView.swift`](Scene/HomeView.swift) | 전체 화면 배경화면 목록과 줌 전환 |
| [`Source/WallpaperPackView.swift`](Source/WallpaperPackView.swift) | 팩 목록, 행 콘텐츠 및 펼침·닫기 버튼 |
| [`Source/WallpaperStackView.swift`](Source/WallpaperStackView.swift) | 겹친 카드와 가로 스크롤 사이의 레이아웃 전환 |
| [`Source/WallpaperPack.swift`](Source/WallpaperPack.swift) | 배경화면 팩 모델과 샘플 데이터 |

## 사용 기술

SwiftUI의 `AnyLayout`, `ScrollView`, `visualEffect`, `matchedTransitionSource` 및 `navigationTransition`

## 참고 자료

[원본 예제 영상](https://www.youtube.com/watch?v=wUKMKMEc0OE)
