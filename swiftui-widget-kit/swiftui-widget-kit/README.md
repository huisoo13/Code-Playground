# SwiftUI WidgetKit 샘플

SwiftUI와 WidgetKit으로 위젯, 컨트롤 위젯, Live Activity의 기본 구성을 살펴보는 iOS 샘플 프로젝트입니다. 앱 화면에는 위젯을 확인하라는 안내가 표시됩니다.

## 구성

- **위젯**: 타임라인 항목의 시간과 설정한 이모지를 표시합니다. 기본 이모지는 😃이며, 현재 시각부터 한 시간 간격으로 다섯 개의 항목을 생성합니다. 마지막 항목 이후 타임라인 갱신을 요청합니다.
- **컨트롤 위젯**: 이름을 설정할 수 있는 타이머 토글 예제입니다. 현재 상태는 `true`로 고정되어 있고, 실제 타이머를 시작하는 동작은 구현되어 있지 않습니다.
- **Live Activity**: 잠금 화면과 Dynamic Island에 이모지를 표시하는 UI 예제입니다. 앱에서 Live Activity를 시작하거나 갱신하는 코드는 아직 없습니다.

위젯은 `accessoryInline`, `accessoryCircular`, `accessoryRectangular` 패밀리만 지원합니다. 앱의 안내 문구와 달리 현재 설정에는 일반 홈 화면 위젯 크기가 포함되어 있지 않습니다. 위젯의 `Configure` 버튼은 설정 인텐트에 연결되어 있으며, 별도의 설정 화면을 여는 동작은 구현되어 있지 않습니다.

## 실행하기

1. Xcode에서 `swiftui-widget-kit.xcodeproj`를 엽니다.
2. `swiftui-widget-kit` 앱 스킴과 iOS 시뮬레이터 또는 기기를 선택하고 실행합니다. 프로젝트의 iOS 배포 대상은 18.5입니다.
3. 지원되는 잠금 화면 위젯 편집 화면에서 앱의 위젯을 추가합니다. 표시되는 옵션은 기기와 OS 환경에 따라 달라질 수 있습니다.
4. Xcode에서 위젯과 Live Activity 소스의 프리뷰를 이용해 예제 화면을 살펴볼 수 있습니다. 위젯 프리뷰는 `.systemSmall`로 선언되어 있지만 실제 지원 패밀리에는 포함되어 있지 않습니다.

실제 기기에서 실행하려면 Xcode의 Signing 설정에서 개발 팀을 선택해야 할 수 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| `swiftui-widget-kit/ContentView.swift` | 앱의 안내 화면 |
| `widget/widgetBundle.swift` | 위젯 확장에 세 가지 위젯 등록 |
| `widget/widget.swift` | 위젯 화면과 타임라인 제공자 |
| `widget/AppIntent.swift` | 이모지 설정 인텐트 |
| `widget/widgetControl.swift` | 타이머 컨트롤 위젯 예제 |
| `widget/widgetLiveActivity.swift` | Live Activity와 Dynamic Island UI 예제 |

SwiftUI, WidgetKit, App Intents, ActivityKit을 사용합니다.
