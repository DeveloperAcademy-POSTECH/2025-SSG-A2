

>[!question]
>- [x] self는 뭐지?
>- [x] self는 왜 사용하지?
>- [x] 같은 이름의 속성이 있는 경우 정확히 self는 어디를 가리키지?
# Description
Swift에서 self는 현재 인스턴스 자신을 가리키는 키워드이다.
보통은 self를 생략해도 되지만, 이름이 겹치는 상황에서 사용하는 키워드이다.
현재 인스턴스를 기준으로 한다.
### 활용 예시
아래는 init에서 활용 예시이다.
self는 인스턴스를 가리키므로 Person을 가리킨다.
그러므로 Person.name = name과 같다.
```swift
struct Person {
	var name: String

	init(name: String) {
		self.name = name // Person.name = name(파라미터)
	}
}
```

```swift
struct Person {
	var name: String

	mutating func changeName(to name: String) { // 외부에서는 to, 내부에서는 name
		self.name = name // Person.name = name
	}
}
```
# Keywords
- 
# References
- 
