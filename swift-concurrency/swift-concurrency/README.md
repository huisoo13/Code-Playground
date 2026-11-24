# Swift Concurrency 샘플

`actor`와 Swift Concurrency를 사용해 비동기 작업을 순차 또는 동시에 실행하는 UIKit 예제입니다.

## 구성

- **Actor** — 내부 정수 값을 관리하고, 서로 다른 대기 시간 뒤에 `A`와 `B`를 출력하는 비동기 메서드를 제공합니다.
- **순차 실행** — `task1()`은 값을 증가시킨 뒤 감소시킵니다. `task2()`는 작업을 다섯 번 순차 실행하고 `AsyncStream`으로 완료 시점을 전달합니다.
- **동시 실행** — `task3()`은 `withTaskGroup`에 동일한 작업을 추가합니다. `task4()`는 서로 다른 두 작업을 `async let`으로 시작하고 둘 모두가 끝날 때까지 기다립니다.
- **콜백 변환** — `withCheckedContinuation`으로 콜백 기반 호출을 `async` 함수에서 기다립니다.

## 실행하기

Xcode에서 `swift-concurrency.xcodeproj`를 열어 실행하면 기본으로 `task4()`가 호출됩니다. Xcode 콘솔에서 두 작업의 로그를 확인할 수 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ViewController.swift`](Scene/ViewController.swift) | 순차 실행, Task Group, `async let`, continuation 예제 |
| [`Source/Actor.swift`](Source/Actor.swift) | Actor의 상태 및 콘솔 출력 메서드 |

## 사용 기술

UIKit과 Swift Concurrency의 `actor`, `Task`, `AsyncStream`, Task Group 및 continuation
