>[!question]
>- [x] Codable은 뭐지?
>- [x] 어디에 쓰는거지?
# Description
Codable은 Swift에서 JSON 같은 데이터를 객체로 바꾸거나, 객체를 다시 데이터로 바꿀 때 사용하는 프로토콜이다.
[[Encodable]]과 [[Decodable]]의 합성 프로토콜이다.

```swift
struct User: Codable {
	let name: String
	let age: Int
}
```
# Keywords
- [[Encodable]]
- [[Decodable]]
# References
- 
