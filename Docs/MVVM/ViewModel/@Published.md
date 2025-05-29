## Description
### Definition
- @Published는 ObservableObject를 채택한 클래스에서 사용되는 **속성 래퍼**로, 상태 값이 변경되었을 때 자동으로 **변화를 알리는 역할**을 한다.
- 이 속성에 연결된 SwiftUI 뷰는 값이 바뀔 때마다 **자동으로 다시 그려진다**.
- SwiftUI에서 ViewModel이 상태를 외부에 **방송(broadcast)** 하기 위해 사용하는 핵심 기능이다.
### Syntax
```swift
class SomeViewModel: ObservableObject {
    @Published var title: String = "Hello"
}
```
- 변수 선언 앞에 @Published를 붙여 사용한다.
- 뷰에서 ViewModel을 @ObservedObject나 @StateObject로 관찰하고 있을 경우, 해당 속성 값이 변경되면 자동으로 UI가 갱신된다.
## 주요 기능
- @Published는 Combine 프레임워크의 Publisher 역할을 내부적으로 수행한다.
- 값이 변경되면 이를 관찰하고 있는 뷰에 **자동으로 변경 사실을 알린다**.
- 이를 통해 SwiftUI의 뷰는 body를 다시 계산하고, UI를 최신 상태로 유지한다.
- 값은 직접 대입하거나, 메서드를 통해 변경할 수 있다.
## Keywords
+ [[Combine]]
+ [[상태방송]]
## References
-  [Combine-Published 공식문서](https://developer.apple.com/documentation/combine/published)