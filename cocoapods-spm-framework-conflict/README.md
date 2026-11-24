# CocoaPods와 Swift Package Manager 프레임워크 충돌 샘플

CocoaPods와 Swift Package Manager(SPM)에서 동일한 프레임워크가 링크될 때 중복 링크를 줄이는 `Podfile` 예제입니다.

## 구성

- **대상 선택** — `post_install` 훅에서 지정한 앱 타깃의 `Pods-<타깃 이름>` 설정을 찾습니다.
- **링커 플래그 수정** — 각 빌드 구성의 `.xcconfig`에서 `OTHER_LDFLAGS` 줄을 찾아 `FBLPromises`, `GoogleDataTransport`, `GoogleUtilities`에 해당하는 `-framework` 항목을 제거합니다.

## 적용하기

`{Target Name}`을 실제 앱 타깃 이름으로 바꾸고, 양쪽에서 링크되는 프레임워크를 확인해 `words` 목록을 조정합니다. 기존 앱의 `Podfile`에 적용한 뒤 `pod install`을 실행하고 생성된 타깃별 설정을 확인합니다. 이 디렉터리는 기존 iOS 앱에 적용하는 템플릿을 제공합니다.

## 주요 파일

| 파일 | 역할 |
| --- | --- |
| [`Podfile`](Podfile) | 예시 타깃, `post_install` 훅, 링커 플래그 수정 함수 |

## 사용 기술

Ruby, CocoaPods의 `post_install` 훅, Xcode의 `.xcconfig` 설정
