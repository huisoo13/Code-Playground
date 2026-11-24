# UIKit과 React Native 연동 샘플

UIKit 앱에서 React Native 화면을 열고 Swift와 TypeScript 사이에서 초기 데이터, Promise 결과, 이벤트를 주고받는 iOS 예제입니다.

## 구성

- **화면 열기** — `Open React Native`를 누르면 `RCTReactNativeFactory`가 React Native 화면을 만들고 `userID`와 `token` 예제 값을 초기 props로 전달합니다.
- **JavaScript에서 Swift 호출** — `callback`에 문자열을 전달하면 네이티브 모듈이 `SUCCESS`로 Promise를 완료합니다.
- **Swift에서 이벤트 발행** — Swift 타이머가 1초마다 `onTimerTick`을 보내고, React Native 화면은 수신한 값을 상태에 저장하고 콘솔에 출력합니다. 타이머는 다섯 번 실행된 후 종료됩니다.

## 실행하기

1. `swift-react-native` 디렉터리에서 Node.js 18 이상으로 `npm ci`를 실행하고 `bundle install`로 Ruby 의존성을 설치합니다.
2. `ios` 디렉터리에서 `bundle exec pod install`을 실행합니다.
3. `swift-react-native` 디렉터리에서 `npm start`로 Metro를 시작하고, Xcode에서 `ios/swift-react-native.xcworkspace`를 열어 Debug 구성을 실행합니다.
4. 앱에서 `Open React Native`를 누르고 타이머와 데이터 통신 버튼을 실행합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ReactViewController.swift`](Scene/ReactViewController.swift) | React Native 화면 생성 및 초기 props 전달 |
| [`Source/ReactNativeDelegate.swift`](Source/ReactNativeDelegate.swift) | Debug·Release 번들 위치와 네이티브 모듈 구성 |
| [`Source/ReactNativeModule.swift`](Source/ReactNativeModule.swift) | Promise 응답과 타이머 이벤트 발행 |
| [`Source/ReactNativeModule.m`](Source/ReactNativeModule.m) | Swift 모듈을 React Native에 노출 |
| [`../../App.tsx`](../../App.tsx) | 초기 props 표시, 모듈 호출 및 이벤트 구독 |
| [`../Podfile`](../Podfile) | iOS 네이티브 의존성 정의 |

## 사용 기술

Swift, UIKit, Objective-C 브리지, React Native 0.78.2, React 19, TypeScript, Metro 및 CocoaPods
