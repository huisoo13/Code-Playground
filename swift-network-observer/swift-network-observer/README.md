# Swift 네트워크 상태 관찰 샘플

`NWPathMonitor`로 기기의 네트워크 경로와 연결 방식을 관찰하는 UIKit 예제입니다.

## Observer 패턴

관찰 대상의 상태가 바뀔 때 등록된 관찰자에게 변경을 알리는 패턴입니다. 이 예제에서는 `NWPathMonitor`가 경로 변경을 감지해 `pathUpdateHandler`로 전달하므로 앱에서 연결 상태를 반복 조회할 필요가 없습니다.

## 구성

- **연결 상태** — `isConnected`는 현재 경로의 사용 가능 여부를, `isExpensive`는 비용이 높은 경로인지 여부를 읽습니다.
- **변경 감지** — 현재 사용 가능한 첫 번째 인터페이스 유형과 이전 값을 비교해 Wi-Fi, 셀룰러 등 연결 방식의 변경을 콘솔에 기록합니다.
- **모니터 시작** — `AppDelegate`가 앱을 시작할 때 공유 `Network` 객체의 모니터를 시작합니다.

## 실행하기

Xcode에서 `swift-network-observer.xcodeproj`를 열어 실행합니다. 기기의 Wi-Fi나 셀룰러 상태를 바꾸고 Xcode 콘솔에서 인터페이스 로그를 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Source/Network.swift`](Source/Network.swift) | 경로 관찰, 연결 상태 조회, 인터페이스 로그 |
| [`Application/AppDelegate.swift`](Application/AppDelegate.swift) | 앱 시작 시 네트워크 모니터 등록 |

## 사용 기술

UIKit, Network 프레임워크의 `NWPathMonitor`와 `NWPath`, `@MainActor`
