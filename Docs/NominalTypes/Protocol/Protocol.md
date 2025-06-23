>[!question]
>- [x] Protocol은 뭐지?
>- [x] 어떨 때에 사용되지?
>- [x] 어떻게 만들지?
# Description
protocol은 공통된 속성과 메소드를 정의해놓은 약속(규약)이다. 클래스, 구조체, 열거형이 이 protocol을 채택하면 그 약속을 반드시 지켜야 한다.

### 왜 쓸까?
- 여러 타입이 같은 기능을 가지게 하고 싶을 때
- [[Dependency Inversion]](의존성 역전)을 통해 유연하고 테스트하기 쉬운 코드를 만들 때

### 어떻게 만들까?
```swift
protocol 이름 {
	// 속성 요구
	var 속성이름: 타입 { get set }

	// 메소드 요구
	func 메소드이름()
}
```

아래와 같이 쓴다.
```swift
protocol Dirivable {
	func drive()
}

struct Car: Drivable {
	func drive() {
		print("운전 중입니다.")
	}
}
```

# Keywords
- [[Identifiable]]
- [[Codable]]
- [[Encodable]]
- [[Decodable]]
- [[CaseIterable]]
- [[Equatable]]
- [[Hashable]]
- [[Comparable]]
- [[RawRepresentable]]
# References
- 
