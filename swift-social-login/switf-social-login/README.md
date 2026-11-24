# UIKit 소셜 로그인 샘플

Apple, Google, Kakao, Naver의 로그인 요청을 하나의 계정 관리 인터페이스에서 다루는 UIKit 예제입니다.

## 구성

- **로그인 화면** — 네 플랫폼의 로그인 버튼을 표시하고, 선택한 공급자의 인증을 요청합니다.
- **공급자별 인증** — `AccountManager`가 공급자별 구현을 호출합니다. `SceneDelegate`는 전달받은 URL을 계정 관리자에 전달해 SDK의 인증 결과를 처리합니다.
- **계정 저장** — 공급자별 응답을 공통 `Account`와 `Profile` 모델로 변환하고, 계정 정보를 Keychain에 저장합니다.

## 실행하기

Xcode에서 `switf-social-login.xcodeproj`를 열고 Swift 패키지 의존성을 가져옵니다. 사용할 플랫폼에 등록한 앱의 설정과 콜백 URL 스킴을 `Info.plist`에 적용합니다. Apple 로그인을 확인하려면 서명 설정과 Sign in with Apple Capability를 구성합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`ViewController.swift`](ViewController.swift) | 공급자 선택과 로그인 요청 |
| [`Utilities/Account/AccountManager.swift`](Utilities/Account/AccountManager.swift) | 공급자 초기화, 인증 요청과 URL 처리 분기 |
| [`Utilities/Account/AccountManager+Apple.swift`](Utilities/Account/AccountManager+Apple.swift) | Sign in with Apple 구현 |
| [`Utilities/Account/AccountManager+Google.swift`](Utilities/Account/AccountManager+Google.swift) | Google 로그인 구현 |
| [`Utilities/Account/AccountManager+Kakao.swift`](Utilities/Account/AccountManager+Kakao.swift) | 카카오 로그인 구현 |
| [`Utilities/Account/AccountManager+Naver.swift`](Utilities/Account/AccountManager+Naver.swift) | 네이버 로그인 구현 |
| [`Utilities/KeychainManager.swift`](Utilities/KeychainManager.swift) | 계정 정보 저장, 조회, 삭제 |
| [`Info.plist`](Info.plist) | SDK 설정과 콜백 URL 스킴 |

## 사용 기술

Swift, UIKit, AuthenticationServices, Security(Keychain), GoogleSignIn, Kakao SDK 및 NidThirdPartyLogin
