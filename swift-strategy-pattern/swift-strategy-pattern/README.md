# Swift Strategy 패턴 샘플

앱 오류를 경고창, 콘솔 로그 또는 두 방식의 조합으로 처리하는 UIKit 예제입니다.

## Strategy 패턴

같은 작업을 수행하는 여러 구현을 공통 인터페이스로 정의하고, 사용하는 곳에서 필요한 구현을 선택하는 행위 패턴입니다. 이 예제에서 오류가 발생하는 코드는 `ErrorHandlingStrategy.handle(_:)`만 호출하므로 경고 표시나 로깅 방식을 독립적으로 바꿀 수 있습니다.

## 구성

- **오류 모델** — 네트워크 오류, 잘못된 입력, 인증 만료 및 알 수 없는 오류를 `AppError`로 정의합니다.
- **처리 전략** — `AlertErrorHandler`는 오류에 맞는 메시지를 경고창에 표시하고 `LoggingErrorHandler`는 콘솔에 오류를 기록합니다. `CompositeErrorHandler`는 여러 핸들러에 같은 오류를 전달합니다.
- **전략 선택** — `ErrorHandlingLevel`에 따라 경고, 로깅, 둘 다 또는 처리 안 함을 설정합니다. 기본값은 `.all`입니다.

## 실행하기

Xcode에서 `swift-strategy-pattern.xcodeproj`를 열어 실행한 뒤 화면을 탭하면 알 수 없는 오류의 경고창과 콘솔 로그를 확인할 수 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Source/AppError.swift`](Source/AppError.swift) | 오류 타입, 전략 인터페이스 및 처리 클래스 |
| [`Scene/ViewController.swift`](Scene/ViewController.swift) | 처리 수준에 따른 전략 선택과 오류 발생 예제 |

## 사용 기술

Swift 프로토콜과 열거형, UIKit 및 `UIAlertController`
