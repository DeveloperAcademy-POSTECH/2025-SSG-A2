>[!question]
>- [x] Hashable은 뭐지?
>- [x] Hashable은 어떨 때 쓰는거지?
# Description
Hashable은 Swift에서 값을 [[hash]]로 바꿔서 비교하거나 저장할 수 있게 해주는 프로토콜이다.
모든 프로퍼티가 Hashable이면 Swift가 자동으로 hash를 만들어준다.
Hashable이 채택되면 Equatable도 자동 채택된다.
[[Set]], [[Dictionary]]의 키로 쓰려면 반드시 Hashable이어야 한다.

사용 방법은 아래와 같다.
```swift
struct Person: Hashable {
	let name: String
	let age: Int
}

let p1 = Person(name: "성현", age: 25)
let p2 = Person(name: "성현", age: 25)
let p3 = Person(name: "케이카", age: 23)

let set: Set = [p1, p2, p3]
print(set.count) // 2 (p1 == p2, 중복 제거됨)
```

같은 값을 가진 객체는 같은 해시값을 가지고 있다.
### Hashable을 사용하면 뭐가 가능할까?
- Set 사용 가능: 중복 없이 저장 가능
- Dictionary 키로 사용 가능: 객체를 키를 쓸 수 있음
- 빠른 비교: 해시값으로 비교해서 성능이 좋음
# Keywords
- [[hash]]
- [[Set]]
- [[Dictionary]]
# References
- 
