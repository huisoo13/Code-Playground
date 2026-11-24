# UIKit Universal Link 샘플

앱이 Universal Link를 받는 시점에 따라 URL을 가져오고, 경로와 쿼리에서 앱 내부 목적지를 해석하는 UIKit 예제입니다.

## 구성

- **링크 수신** — 새 장면을 연결할 때는 `UIScene.ConnectionOptions`에서 링크를 읽어 목적지를 저장합니다. 앱이 실행 중이면 `scene(_:continue:)`에서 전달받은 링크를 즉시 처리합니다.
- **목적지 파싱** — `/home`, `/today`, `/contents?id=1` 같은 경로를 열거형으로 변환합니다. 알 수 없는 경로나 콘텐츠 ID가 빠진 링크는 `.home`으로 해석합니다.
- **예제 범위** — 목적지별 화면 표시 코드는 비어 있습니다. 지연된 딥 링크를 복원하는 메서드의 서버 호출도 자리표시자로 남아 있습니다.

## 실행하기

실제 링크 수신을 확인하려면 `swift-universal-link.entitlements`의 `applinks:domain.com`을 테스트 도메인으로 바꾸고, 해당 도메인에 앱의 식별자와 테스트 경로를 포함한 `apple-app-site-association` 파일을 설정합니다. Xcode에서 `swift-universal-link.xcodeproj`를 열어 실행하고 수신 지점에서 파싱된 목적지를 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Application/SceneDelegate.swift`](Application/SceneDelegate.swift) | 앱 실행 시점별 웹 링크 수신 |
| [`Source/UniversalLinkManager.swift`](Source/UniversalLinkManager.swift) | 링크 수신 경로 분기, 목적지 보관 및 실행 지점 |
| [`Source/UniversalLinkType.swift`](Source/UniversalLinkType.swift) | 목적지 정의, URL 파싱 및 `Codable` 구현 |
| [`swift-universal-link.entitlements`](swift-universal-link.entitlements) | Associated Domains 예제 설정 |

## 사용 기술

Swift, UIKit의 `UISceneDelegate`, `NSUserActivity`, Foundation의 `URLComponents` 및 Associated Domains
