>[!question]
>- [x] Decodable은 뭐지?
# Description
Decodable은 JSON, plist, Data 등을 객체로 바꾸는 프로토콜이다.
즉, 데이터를 받아서 디코딩한다.

```swift
struct User: Decodable {
	let name: String
	let age: Int
}

let json = """
{
	"name": "케이카",
	"age": 23
}
""".data(using: .utf8)!

let user = try JSONDecoder().decode(User.self, from:json) // JSON -> 객체
```
# Keywords
- 
# References
- 
