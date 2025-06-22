
>[!question]
>- [x] State Management는 뭐지?
>- [x] 왜 사용하지?
# Description
State Management(상태 관리)는 뷰의 UI를 데이터의 상태에 따라 자동으로 업데이트하는 핵심 개념이다.
뷰는 상태(State)에 따라 그려지고, 상태가 바뀌면 자동으로 다시 그려진다.

SwiftUI에서 State Management는 Property Wrapper로 할 수 있다.
[[@State]], [[@Binding]], [[@Observable]], [[@StateObject]], [[@ObservedObject]], [[@EnvironmentObejct]]로 나뉘어진다.

간단한 State Management는 [[@State]], [[@Binding]]로 가능하다.
복잡한 모델의 State Management는 [[@Observable]], [[@StateObject]], [[@ObservedObject]]를 사용한다.
앱 전역 공유는 [[@EnvironmentObejct]]를 사용한다.
### 상태 흐름의 핵심 규칙
1. 단일 상태 소유 (Source of Truth): 상태는 하나의 뷰 또는 객체만이 소유
2. 단방향 데이터 흐름: 데이터는 위 -> 아래 방향으로 흐름
3. 자동 갱신: 변화가 생기면 자동으로 UI가 그려짐
# Keywords
- [[@State]]
- [[@Binding]]
- [[@Observable]]
- [[@StateObject]]
- [[@ObservedObject]]
- [[@EnvironmentObejct]]
# References
- 
