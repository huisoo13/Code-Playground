# SwiftUI 이미지 뷰어 샘플

원격 이미지를 그리드로 표시하고 선택한 이미지를 전체 화면에서 넘기거나 확대하는 SwiftUI 예제입니다.

## 구성

- **썸네일 그리드** — 원격 이미지 URL을 섹션별 4열 그리드로 표시합니다. 뷰어에서 선택이 바뀌면 그리드도 해당 썸네일 위치로 이동합니다.
- **전체 화면 뷰어** — 탭한 이미지부터 페이지 형식으로 표시하며 좌우로 넘길 수 있습니다. 마지막 이미지에 도달하면 추가 로딩 지점의 로그를 출력합니다.
- **확대 및 이동** — `UIScrollView`를 SwiftUI에 연결해 핀치로 최대 4배 확대할 수 있습니다. 확대 중에는 바깥쪽 페이지 스크롤을 비활성화해 이미지 안에서 이동할 수 있게 합니다.

## 실행하기

Xcode에서 `swiftui-image-viewer.xcodeproj`를 열고 Kingfisher 의존성을 가져옵니다. 인터넷에 연결된 환경에서 실행해 썸네일을 탭하고 핀치 확대와 페이지 이동을 확인합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Scene/ContentView.swift`](Scene/ContentView.swift) | 썸네일 그리드, 예제 URL, 선택 및 스크롤 동기화 |
| [`Scene/ImageViewer.swift`](Scene/ImageViewer.swift) | 전체 화면 페이지, 원격 이미지 로딩과 닫기 버튼 |
| [`Source/ZoomableScrollView.swift`](Source/ZoomableScrollView.swift) | UIKit 스크롤 뷰 기반 확대와 제스처 조정 |

## 사용 기술

SwiftUI, UIKit의 `UIScrollView`와 `UIHostingController`, Kingfisher, Swift Package Manager
