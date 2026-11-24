# UIKit MVVM 패턴 샘플

버튼으로 숫자 변경을 요청하고, 모델의 변경 사항을 구독하는 UIKit 예제입니다.

## Model–View–ViewModel 패턴

Model은 데이터를 담고, ViewModel은 화면에 필요한 상태와 상태 변경 동작을 제공합니다. View는 사용자 입력을 ViewModel에 전달하고 그 결과를 구독합니다. 이 예제에서는 직접 구현한 `Observable<T>`가 구독을 연결합니다.

## 구성

- **Model** — 초기 문자열과 숫자를 담는 값 타입입니다.
- **ViewModel** — 모델을 `Observable<Model>`로 감싸고, 문자열이나 숫자 변경 요청을 약 1초 뒤에 적용합니다.
- **View** — 버튼을 누르면 다음 숫자를 ViewModel에 전달합니다. 구독 콜백은 초기 상태와 변경된 모델을 Xcode 콘솔에 출력합니다.

## 실행하기

Xcode에서 `swift-mvvm-pattern.xcodeproj`를 열어 실행합니다. 파란 버튼을 누른 뒤 Xcode 콘솔에서 숫자가 바뀐 모델을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ViewController.swift`](Scene/ViewController.swift) | 버튼 입력과 모델 변경 구독 |
| [`Source/ViewModel.swift`](Source/ViewModel.swift) | 비동기 모델 갱신 |
| [`Source/Model.swift`](Source/Model.swift) | 예제 상태 |
| [`Source/Observable.swift`](Source/Observable.swift) | 변경 전달과 옵저버 수명 관리 |

## 사용 기술

Swift, UIKit, 제네릭, 클로저 및 Swift Concurrency
