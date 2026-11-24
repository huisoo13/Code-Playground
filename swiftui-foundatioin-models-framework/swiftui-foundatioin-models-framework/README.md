# SwiftUI Foundation Models 샘플

Apple의 Foundation Models 프레임워크를 사용해 장난감 위시리스트를 생성하고 결과를 받는 대로 화면에 표시하는 SwiftUI 예제입니다.

## 구성

- **구조화된 응답** — `@Generable`로 `WishListItem`을 정의하고 `@Guide`로 상품명 필드의 의미를 전달합니다.
- **스트리밍** — `LanguageModelSession.streamResponse`에 위시리스트 항목 15개를 요청합니다. 응답에서 ID와 상품명이 모두 도착한 항목을 목록에 표시합니다.
- **생성 상태** — 생성 중에는 버튼을 비활성화하고, 오류가 발생하면 오류 메시지와 모델의 가용 상태를 콘솔에 출력합니다.

## 실행하기

Xcode에서 `swiftui-foundatioin-models-framework.xcodeproj`를 열어 실행합니다. 목록 생성에는 시스템 언어 모델을 사용할 수 있는 환경이 필요하며, 생성 버튼은 `ContentView`의 하단 툴바에 정의되어 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`ContentView.swift`](ContentView.swift) | 위시리스트 UI, 구조화된 모델 응답 및 스트리밍 처리 |
| [`swiftui_foundatioin_models_frameworkApp.swift`](swiftui_foundatioin_models_frameworkApp.swift) | 앱 진입점과 루트 화면 |

## 사용 기술

SwiftUI, Foundation Models의 `LanguageModelSession`, `@Generable` 및 `@Guide`, Swift Concurrency
