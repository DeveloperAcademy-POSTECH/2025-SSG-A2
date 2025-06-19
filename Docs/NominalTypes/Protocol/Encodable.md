>[!question]
>- [x] Encodable은 뭐지?지?
# Description
Encodable은 객체 -> JSON, plist, Data 등으로 바꾸는 프로토콜이다.
즉, 저장하거나 전송하기 위해 인코딩하는 것이다.
```Swift
struct User: Encodable {
	let name: String
	let age: Int
}

let user = User(name: "성현", age: 25)
let jsonData = try JSONEncoder().encode(user) // 객체 -> JSON
```

# Keywords
- 
# References
- 
