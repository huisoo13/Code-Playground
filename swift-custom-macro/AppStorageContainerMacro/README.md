# Swift AppStorage 컨테이너 매크로 샘플

프로퍼티의 기본값과 `AppStorage` 저장 코드를 매크로로 연결하는 Swift Package 예제입니다.

## 구성

- **`@AppStorageContainer`** — 타입과 초기값을 명시한 프로퍼티에서 `StorageFromMacro`, 저장소 프로퍼티와 초기화 코드를 생성합니다. 저장 키는 `<프로퍼티 이름>_app_storage` 형식입니다.
- **`@AppStored`** — 생성한 `didSet`에서 변경된 값을 저장소에 전달합니다.
- **예제 클라이언트** — 매크로를 적용한 `TestObject1`과 저장 코드를 직접 작성한 `TestObject2`를 비교합니다.

## 빌드 상태

Swift 도구 버전은 6.2입니다. 예제 클라이언트에는 `@Observable`과 `didSet`을 함께 사용할 때의 동작을 기록한 `#error`가 있어 현재 상태로는 실행 타깃 빌드가 중단됩니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Package.swift`](Package.swift) | Swift 6.2 도구 버전, SwiftSyntax 의존성과 타깃 정의 |
| [`Sources/AppStorageContainerMacro/AppStorageContainerMacro.swift`](Sources/AppStorageContainerMacro/AppStorageContainerMacro.swift) | 공개 매크로 선언 |
| [`Sources/AppStorageContainerMacroMacros/AppStorageContainerMacroMacro.swift`](Sources/AppStorageContainerMacroMacros/AppStorageContainerMacroMacro.swift) | 멤버, 속성, 접근자 확장 구현 |
| [`Sources/AppStorageContainerMacroClient/main.swift`](Sources/AppStorageContainerMacroClient/main.swift) | 매크로 적용 및 직접 구현 비교 코드 |

## 사용 기술

Swift Package Manager, SwiftSyntax, Swift Compiler Plugin, SwiftUI의 `AppStorage`와 Observation
