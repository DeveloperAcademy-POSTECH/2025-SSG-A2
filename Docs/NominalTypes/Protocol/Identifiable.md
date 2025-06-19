>[!question]
>- [x] Identifiable은 뭘까
>- [x] Identifiable은 언제 쓰는 걸까
# Description
Identifiable은 고유한 ID가 있는 타입임을 나타내는 Protocol이다.
List, ForEach 같은 SwiftUI 뷰에서 반복 출력할 때 꼭 필요하다.
즉, 고유한 id가 있으므로, 각 아이템이 유일하게 구분될 수 있다는 것을 보증한다.

```swift
protocol Identifiable {
	associatedType ID: Hashable
	var id: Id { get }
}
```

# Keywords
- [[associatedType]]
# References
- 
