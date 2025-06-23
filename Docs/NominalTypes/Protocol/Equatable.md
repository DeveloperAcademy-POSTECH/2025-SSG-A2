>[!question]
>- [x] Equatable은 뭐지?
>- [x] Equatable은 왜 사용하지?
# Description
Equatable은 Swift에서 두 값이 같은지 비교할 수 있게 해주는 프로토콜이다.
\==, != 같은 연산자를 쓸 수 있게 해준다.

다음과 같이 사용한다.
```swift
struct Person: Equatable {
	let name: String
	let age: Int
}

let a = Person(name: "성현", age: 25)
let b = Person(name: "성현", age: 25)
let c = Person(name: "케이카", age: 23)

print(a == b) // true
print(a == c) // false
```
# Keywords
- 
# References
- 
