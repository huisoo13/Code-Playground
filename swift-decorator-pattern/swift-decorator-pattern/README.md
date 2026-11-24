# Swift Decorator 패턴 샘플

마라탕의 맵기와 토핑을 선택하고 조합에 따른 설명과 가격을 확인하는 UIKit 예제입니다.

## Decorator 패턴

같은 인터페이스를 구현하는 객체로 기존 객체를 감싸고, 호출을 전달하면서 동작을 덧붙이는 구조 패턴입니다. 여러 토핑이 `Maratang`을 차례로 감싸므로 기본 마라탕의 구현을 바꾸지 않고도 가격과 설명을 조합할 수 있습니다.

## 구성

- **기본 마라탕** — 순한 맛, 덜 매운맛, 매운맛의 기본 가격과 설명을 정의합니다.
- **토핑** — 면, 고기, 채소가 기존 객체를 감싸고 재료 이름과 가격을 더합니다.
- **주문 화면** — 버튼으로 맵기를 고르고 토핑을 추가하거나 제거합니다. 현재 조합과 가격은 콘솔에 출력됩니다.

## 실행하기

Xcode에서 `swift-decorator-pattern.xcodeproj`를 열어 실행합니다. 맵기와 토핑 버튼을 눌러 Xcode 콘솔에서 메뉴 설명과 가격을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Decorator/Decorator.swift`](Decorator/Decorator.swift) | `Maratang`과 `Topping` 프로토콜, 기본 메뉴와 토핑 구현 |
| [`Scene/ViewController.swift`](Scene/ViewController.swift) | 맵기 및 토핑 선택, 현재 조합 출력 |
| [`Scene/Base.lproj/Main.storyboard`](Scene/Base.lproj/Main.storyboard) | 재료와 맵기 선택 버튼 배치 |

## 사용 기술

Swift 프로토콜과 제네릭, UIKit 및 Storyboard
