# SwiftUI VIP 패턴 샘플

1부터 100 사이의 숫자를 맞히는 업다운 게임으로 View, Interactor, Presenter의 연결을 보여주는 SwiftUI 예제입니다.

## View–Interactor–Presenter 패턴

View는 사용자 입력과 화면 표시를 맡고, Interactor는 요청을 받아 유스케이스를 처리하며, Presenter는 결과를 화면에 표시할 상태로 변환하는 구조입니다. 이 예제에서는 `View → Interactor → Presenter → View` 흐름을 보여주며, 실제 정답 판정은 Presenter에 들어 있습니다.

## 구성

- **View** — 숫자 입력과 제출, 다시 시작 이벤트를 Interactor에 전달합니다. Presenter의 상태를 관찰해 힌트와 남은 기회를 표시합니다.
- **Interactor** — 입력 변경, 제출 및 초기화 요청을 Presenter에 전달합니다.
- **Presenter** — 정답, 입력값, 남은 기회와 화면 표시 상태를 보관합니다. 제출한 숫자를 비교해 업·다운이나 성공·실패 상태를 선택합니다. 숫자로 변환할 수 없는 입력도 현재 구현의 기본 분기에서 성공으로 처리됩니다.

## 실행하기

Xcode에서 `swiftui-vip-pattern.xcodeproj`를 열어 실행합니다. 숫자를 입력하고 키보드에서 제출해 업·다운 힌트와 남은 기회를 확인한 뒤 `다시하기`로 초기화합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 게임 화면 진입점 |
| [`Scene/Feature/FeatureView.swift`](Scene/Feature/FeatureView.swift) | `FeatureBuilder`, 입력 바인딩과 게임 상태 표시 |
| [`Scene/Feature/FeatureInteractor.swift`](Scene/Feature/FeatureInteractor.swift) | 사용자 동작을 받아 Presenter에 전달 |
| [`Scene/Feature/FeaturePresenter.swift`](Scene/Feature/FeaturePresenter.swift) | 정답 생성, 기회 계산과 상태 변경 |

## 사용 기술

SwiftUI의 `Binding`, `@State`, Observation의 `@Observable`, 의존성 주입
