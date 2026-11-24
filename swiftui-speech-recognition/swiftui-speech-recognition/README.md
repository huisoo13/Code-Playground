# SwiftUI 실시간 음성 인식 샘플

마이크 입력을 한국어 텍스트로 변환하고 인식 중간 결과를 화면에 표시하는 SwiftUI 예제입니다.

## 구성

- **권한과 준비** — 음성 인식 서비스를 사용할 수 있는지 확인하고 음성 인식 및 마이크 접근 권한을 요청합니다.
- **실시간 변환** — `AVAudioEngine`에서 받은 입력 버퍼를 `SFSpeechAudioBufferRecognitionRequest`에 추가합니다. `ko-KR` 인식기의 중간 결과가 들어올 때마다 화면의 텍스트를 갱신합니다.
- **녹음 제어** — 마이크 버튼으로 인식을 시작하거나 중지합니다. 중지할 때 인식 작업과 오디오 입력을 정리하고 이전 오디오 세션 설정을 복원합니다.

## 실행하기

Xcode에서 `swiftui-speech-recognition.xcodeproj`를 열어 실행합니다. 음성 인식과 마이크 권한을 허용한 뒤, 마이크 버튼을 누르고 한국어로 말해 화면의 중간 인식 결과를 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 인식 결과 표시, 권한 준비 및 시작·중지 버튼 |
| [`Source/SpeechManager.swift`](Source/SpeechManager.swift) | 권한, 오디오 세션, 버퍼 전달과 인식 작업 |
| [`../swiftui-speech-recognition.xcodeproj/project.pbxproj`](../swiftui-speech-recognition.xcodeproj/project.pbxproj) | 마이크와 음성 인식 권한 안내 문구 |

## 사용 기술

SwiftUI, Speech의 `SFSpeechRecognizer`, AVFoundation의 `AVAudioEngine`과 `AVAudioSession`, Observation
