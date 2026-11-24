# UIKit 텍스트 필드 글자 수 제한 샘플

`UITextField`에서 다섯 글자 제한을 처리하는 두 가지 방식과, 제한을 넘긴 입력을 표시하는 방식을 비교하는 UIKit 예제입니다.

## 구성

- **Delegate 방식** — 입력 적용 전에 `shouldChangeCharactersIn`에서 변경 결과의 Unicode 스칼라 수를 검사합니다. 제한에 도달했을 때 일부 한글 자모 조합은 계속 허용합니다.
- **이벤트 방식** — `.editingChanged`에서 `String.count`를 검사하고, 제한을 초과하면 마지막으로 허용한 문자열을 복원합니다.
- **입력 피드백** — 입력을 유지하면서 현재 글자 수를 표시합니다. 제한을 넘기면 카운터 색이 바뀌고 흔들림과 햅틱 피드백이 발생합니다.

## 실행하기

Xcode에서 `swift-text-field-character-limit.xcodeproj`를 열어 실행합니다. 다섯 글자를 넘는 텍스트를 입력하고, 한글과 이모지에서 각 처리 방식의 차이를 확인할 수 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/UsingDelegateViewController.swift`](Scene/UsingDelegateViewController.swift) | 입력 전 검사와 한글 조합 처리 |
| [`Scene/UsingEventViewController.swift`](Scene/UsingEventViewController.swift) | 입력 후 검사와 이전 값 복원 |
| [`Scene/OtherViewController.swift`](Scene/OtherViewController.swift) | 글자 수 표시, 햅틱 및 흔들림 애니메이션 |
| [`Scene/Base.lproj/Main.storyboard`](Scene/Base.lproj/Main.storyboard) | 세 입력 예제 화면 레이아웃 |

## 사용 기술

Swift 문자열과 Unicode, UIKit의 `UITextFieldDelegate` 및 편집 이벤트, Core Animation
