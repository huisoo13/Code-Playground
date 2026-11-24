# SwiftUI 채팅 화면 샘플

메시지를 입력해 전송하면 텍스트가 입력창에서 목록의 말풍선으로 이동하는 애니메이션을 보여주는 SwiftUI 예제입니다.

## 구성

- **메시지 목록** — 샘플 메시지를 세로 목록으로 표시하고 초기 스크롤 기준점을 하단에 맞춥니다.
- **입력창** — Liquid Glass를 적용한 여러 줄 입력창으로 메시지를 작성합니다. 입력 내용이 비어 있으면 전송 버튼이 비활성화됩니다.
- **전송 애니메이션** — 메시지를 화면의 상태에 추가하고, `matchedGeometryEffect`와 키프레임으로 입력 위치에서 말풍선 위치까지 전환합니다.

## 실행하기

Xcode에서 `swiftui-chat-view.xcodeproj`를 열어 실행합니다. 짧은 메시지와 여러 줄 메시지를 입력해 말풍선으로 전환되는 모습을 확인할 수 있습니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 채팅 화면과 내비게이션 바 |
| [`Scene/ChatView.swift`](Scene/ChatView.swift) | 메시지 목록, 입력창 및 전송 전환 처리 |
| [`Scene/MessageBubbleView.swift`](Scene/MessageBubbleView.swift) | 말풍선과 키프레임 애니메이션 |
| [`Source/Message.swift`](Source/Message.swift) | 메시지 모델과 샘플 데이터 |

## 사용 기술

SwiftUI, Liquid Glass, `matchedGeometryEffect` 및 `keyframeAnimator`
