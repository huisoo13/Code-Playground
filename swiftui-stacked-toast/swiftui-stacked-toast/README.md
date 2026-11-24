# SwiftUI 스택형 토스트 샘플

화면 하단에서 여러 토스트 알림을 겹쳐 표시하고 각 알림이 나타나고 사라지는 전환을 보여주는 SwiftUI 예제입니다.

## 구성

- **스택 배치** — 알림 순서에 따라 크기와 위치를 조정하고 가장 최근 알림을 앞에 배치합니다.
- **표시 효과** — 토스트에 그레이디언트와 Liquid Glass를 적용합니다. 예제 화면의 슬라이더는 라이트 모드의 유리 효과 색조 투명도를 조절합니다.
- **닫기 동작** — 예제 토스트는 2초 뒤 자동으로 닫힙니다. 코드에서는 스와이프 삭제 액션도 정의하며 주석에는 해당 `VStack` 스와이프 동작의 지원 환경을 iOS 27 이상으로 명시합니다.

## 실행하기

Xcode에서 `swiftui-stacked-toast.xcodeproj`를 열어 실행합니다. `Add Toast`를 연속으로 눌러 토스트가 겹쳤다가 순서대로 사라지는 모습을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 토스트 추가 버튼, 투명도 슬라이더 및 하단 오버레이 |
| [`Source/StackedToast.swift`](Source/StackedToast.swift) | 토스트 모델, 카드 배치와 전환, 자동 닫기 처리 |

## 사용 기술

SwiftUI의 `visualEffect`, `MeshGradient`, Liquid Glass 및 Swift Concurrency

## 참고 자료

[원본 예제 영상](https://www.youtube.com/watch?v=4cLWzZ7_0Bk)
