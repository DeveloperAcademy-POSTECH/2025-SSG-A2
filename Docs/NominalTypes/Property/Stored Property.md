
>[!question]
>- [x] Stored Property는 뭐지?
>- [x] 어떨때 왜 사용하지?
>- [x] willSet과 didSet을 사용할 수 있는건가? 이건 뭐지?
# Description
Stored Property(저장 속성)은 swift에서 실제로 값을 저장하는 속성이다.
클래스나 구조체 안에 정의된 변수나 상수가 바로 그것이다.
[[Property Observer]]도 사용할 수 있다.
### 코드 예시
아래 코드에서 name과 birthYear이 stored property다.
실제 메모리에 값이 저장되어 있다.
```swift
struct User {
	var name: String
	let birthYear: Int
}
```

# Keywords
- [[Property Observer]]
# References
- 
