# SwiftUI MVI 패턴 샘플

키오스크의 메뉴 선택, 수량 변경, 주문 완료·취소를 단방향 상태 흐름으로 구현한 SwiftUI 예제입니다.

## Model–View–Intent 패턴

View가 사용자 입력을 Intent로 표현하고, 상태 처리 로직이 Intent를 받아 Model을 변경하면 View가 그 상태를 다시 표시하는 패턴입니다. 이 예제는 `버튼 입력 → KioskIntent → reduce → KioskState → View 갱신` 순서로 동작합니다.

## 구성

- **Model과 상태** — `MenuItem`과 `OrderItem`으로 메뉴와 주문을 표현합니다. `KioskState`는 주문 목록과 완료 여부를 보관하고 총액을 계산합니다.
- **Intent와 리듀서** — `KioskIntent`가 메뉴 추가, 수량 증감, 삭제, 완료, 취소를 표현합니다. `reduce(state:intent:)`가 각 의도에 맞게 상태를 변경합니다.
- **View** — 메뉴와 주문 내역을 표시하고, 주문이 완료되면 편집을 비활성화하고 새 주문을 시작할 수 있게 합니다.

## 실행하기

Xcode에서 `swiftui-mvi-pattern.xcodeproj`를 열어 실행합니다. 메뉴를 추가하고 수량을 조정해 합계를 확인한 뒤 주문을 완료하고 `새 주문`으로 상태를 초기화합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 키오스크 화면과 버튼별 Intent 전달 |
| [`Source/Intent.swift`](Source/Intent.swift) | 사용자 Intent 정의와 상태 변경 로직 |
| [`Source/State.swift`](Source/State.swift) | 관찰 가능한 주문 상태와 총액 계산 |
| [`Source/Model.swift`](Source/Model.swift) | 메뉴와 주문 데이터 모델 |

## 사용 기술

SwiftUI, Observation의 `@Observable`과 `@Bindable`, Swift 열거형
