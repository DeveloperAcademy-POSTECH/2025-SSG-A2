>[!question]
>- [x] RawRepresentable은 뭐야?
>- [x] RawRepresentable은 어떨 때 써?
# Description
RawRepresentable은 Swift에서 열거형(enum)이나 타입이 원시값(raw value)를 가질 수 있도록 해주는 프로토콜이다.

enum이 Int, String, Double 등 기본 타입을 raw value로 가질 때 자동으로 RawRepresentable이 채택됨.
### 언제 쓰지?
enum에 숫자, 문자열과 같은 기본값을 붙이고 싶을 때
rawValue로 변환하거나, 반대로 rawValue로부터 enum 생성할 때 (아래 코드의 d2의 경우)
### 사용 예시
```swift
enum Direction: String, RawPresentable {
	case north = "북"
	case south = "남"
	case east = "동"
	case west = "서"
}

let d: Direction = .north
print(d.rawValue) // "북"

let d2 = Direction(rawValue: "서")
print(d2) // Optional(Direction.west)
```
# Keywords
- [[enum]]
# References
- 
