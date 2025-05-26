>[!question]
>GQ1. Extension이란 무엇인가
>GQ2. Extension의 사용 범위는 어디까지인가
## Description
### Extension(확장)이란?
기존 클래스 ,구조체, 열거형 타입에 새로운 Property, Methodm Initializer 등을 추가하는 것으로, 원본 타입(소스 코드)에 접근하지 못하는 타입들도 확장해서 사용할 수 있다.

### Extension이 타입에 추가할 수 있는 기능
- 연산 타입 프로퍼티 / 연산 인스턴스 포르퍼티
- 타입 메서드 / 인스턴스 메서드
- 이니셜라이저
- 서브스크립트
- 중첩타입
- 특정 프로토콜을 준수 할 수 있는 기능 추가

### Syntax
```swift
extension SomeType {
	// SomeType에 추가한 새로운 기능
}
```
Protocol 채택 버전
```swift
extension SomeType: SomeProtocol, AnotherProtocol {
	// 프로토콜 요구사항 작성
}
```

## 코드 예시
+ 나의 C2 코드 일부
```swift
extension Color {
    static let mainColor = Color(red: 0xA1 / 255, green: 0xEF / 255, blue: 0xFF / 255) // 툴바 색
    static let expColor = Color(red: 0x44 / 255, green: 0x70 / 255, blue: 0xFF / 255) // 경험기간 표시색
    static let cardColor = Color(red: 0xF5 / 255, green: 0xF5 / 255, blue: 0xF5 / 255) // 게시물, 댓글 배경색
    static let wordSecondayColor = Color(red: 0xFF / 255, green: 0xAC / 255, blue: 0x2F / 255) // 글자 세컨더리 색
}
```

```swift
 .toolbarBackground(Color.mainColor, for: .navigationBar)
 // 상위 네비게이션바 색깔 지정
```

## 주요 기능
+ 연산 타입 프로퍼티
```swift
extension Double { 
	var km: Double { return self * 1_000.0 } 
	var m: Double { return self } 
	var cm: Double { return self / 100.0 } 
	var mm: Double { return self / 1_000.0 } 
	var ft: Double { return self / 3.28084 } 
} 

let oneInch = 25.4.mm 
print("One inch is \(oneInch) meters") 
// Prints "One inch is 0.0254 meters" 
let threeFeet = 3.ft 
print("Three feet is \(threeFeet) meters") 
// Prints "Three feet is 0.914399970739201 meters"

let aMarathon = 42.km + 195.m 
print("A marathon is \(aMarathon) meters long") // Prints "A marathon is 42195.0 meters long"
```
- 이니셜라이저
	```swift
	struct Size {
		var width = 0.0, height = 0.0
	}
	
	struct Point {
		var x = 0.0, y = 0.0
	}
	
	struct Rect {
		var origin = Point()
		var size = Size()
	}
	
	extension Rect { 
		init(center: Point, size: Size) { 
			let originX = center.x - (size.width / 2) 
			let originY = center.y - (size.height / 2) 
			self.init(origin: Point(x: originX, y: originY), size: size) 
		} 
	}
	let defaultRect = Rect() 
	let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 5.0, height: 5.0))
	
	let centerRect = Rect(center: Point(x: 4.0, y: 4.0), 
		size: Size(width: 3.0, height: 3.0)) 
	// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
	```
	기존에는 Rect를 만들려면 origin(시작점)을 기준으로 만들어야 한다.
	하지만 extension을 써서 만들면 center를 기준으로 Rect를 만들 수 있다.

- 메서드
```swift
extension Int {
	for repititions(task: () -> Void) {
		for _ in 0..<self {
			task()
		}
	}
}

3.repititions {
	print("Hello!")
}
// Hello!
// Hello!
// Hello!
```
- Mutating 인스턴스 메서드
```swift
extension Int {
	mutating func square() {
		self = self * self
	}
}

var someInt = 3
someInt.square()
// someInt = 9
```
- Subscripts
```swift
extension Int {
	subscript(digitIndex: Int) -> Int {
		var decimalBase = 1
		for _ in 0..<digitIndex {
			decimalBase *= 10
		}
		return (self / decimalBase) % 10
	}
}
746381295[0] 
// returns 5 
746381295[1] 
// returns 9 
746381295[2] 
// returns 2 
746381295[8] 
// returns 7
746381295[9] 
// returns 0, as if you had requested: 
0746381295[9]
```
- 중첩 타입
```swift
extension Int {
	enum kind {
		case negative, zero, positive
	}
	var kind: Kind {
		switch self {
		case 0:
			return .zero
		case let x where x > 0:
			return .positive
		default:
			return .negative
		}
	}
}

func printIntegerKinds(_ numbers: [Int]) { 
	for number in numbers { 
		switch number.kind { 
		case .negative: 
			print("- ", terminator: "") 
		case .zero: 
			print("0 ", terminator: "") 
		case .positive: 
			print("+ ", terminator: "") 
		} 
	} print("") 
} 
printIntegerKinds([3, 19, -27, 0, -6, 0, 7]) 
// Prints "+ + - 0 - 0 + "
```
- [[프로토콜 지향 프로그래밍 (POP)#코드 예시#프로토콜 추기구현|프로토콜 초기구현]]
## Keywords
+ 메서드
+ 이니셜라이저
+ 서브스크립트
+ 중첩 타입(Nested Types)

## References
- [swift.org](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/extensions/)