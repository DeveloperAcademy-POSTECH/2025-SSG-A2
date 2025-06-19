>[!question]
>- [x] Comparable은 뭐지?
>- [x] Comparable은 왜 사용하지?
# Description
Comparable은 Swift에서 크기 비교(정렬 등)를 가능하게 해주는 프로토콜이다.
<,>,<=,>= 연산자를 쓸 수있게 된다.

### 자동 정렬
sorted(), min(), max() 등을 이요하여 자동 정렬이 가능하다.
### Equatable과의 관계
Equatable은 같은지 여부를 비교한다.
Comparable은 크기를 비교한다. (<,>,정렬 등)
Comparable을 채택하면 자동으로 Equatable도 포함된다.

### 사용 방법
```swift
struct Socre: Comparable {
	let value: Int

	// 연산자를 이렇게 만들어 줄 수 있다. 아래에서 연산자를 쓰는 것처럼 연산자를 함수로 정의하면 특수취급이 되어 양쪽 값이 파라미터로 들어간다.
	static func < (lsh: Score, rhs: Score) -> Bool {
		return lhs.value < rhs.value
	}
}

// 이제 이렇게 비교 가능
let a = Score(value: 80)
let b = Score(value: 90)

// a와 b는 lsh와 rhs라는 파라미터로 들어가게 된다.
print(a < b) // true
```

# Keywords
- [[Equatable]]
# References
- 
