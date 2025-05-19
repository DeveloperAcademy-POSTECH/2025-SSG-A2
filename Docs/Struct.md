>[!question]
>GQ1. Struct는 뭐지?
>GQ2. SwiftUI에서 struct가 선호되는 이유는 무엇인가?
## Description
### Struct의 정의
Struct는 구조체라고 한다. User-defined Data Type 중 하나를 일컫는다.
### SwiftUI에서 Struct가 선호되는 이유
- Struct는 Class에 비해 가볍다.
- Struct는 상속을 하지 않는다.
- 가변성을 최소화한다.
- Value Type이다.
- memory leak에 안정적이다.

## 주요 기능
### User-defined Data Type (사용자 정의 데이터 타입)
사용자가 정의한 데이터 타입을 의미한다.
### Value Type (값 타입)
Value Type과 Reference Type 중 Value Type에 해당한다.
Value Type은 복사하면 독립된 값이 생기는 타입이다. 
값이 공유되지 않아, 수정 시에도 서로 영향을 주지 않는다.
### Stack에 저장
선입 후출인 Stack을 사용한다. 속도가 빠르다.
### COW (Copy on Write)
'진짜로 사용하기 전까지는 참조 형태로 값을 저장'이다.
메모리를 효율적으로 사용하기 위해 struct를 복사하더라도 해당 struct가 사용될 때까지는 reference type과 같이 포인터 형태로 stack에 저장된다. 그리고 사용되더라도 새로운 heap 공간에 복사를 하고, 그 포인터 형태로 값이 저장된다.
### Mutating
mutating은 struct나 enum에서 자기 자신의 값을 바꾸는 함수를 만들 때 붙이는 키워드이다.
Struct는 Value Type이라 원래는 내부 값을 바꿀 수 없지만, mutating 키워드를 통해 바꿀 수 있다.

### Memberwise Initializer
멤버와이즈 이니셜라이저라고 한다. struct는 class와 다르게, 모든 저장 프로퍼티를 매개변수로 받는 init을 swift에서 자동 생성해준다.
## 코드 예시

struct를 활용한 예시로 User sturct를 만들어보았다.
mutating을 통해 내부 값인 age를 수정할 수 있는 method를 만들었다.
```swift
struct User {
	var name: String
	var age: Int
	var address: String

	mutating func haveBirthday() {
		age += 1
	}

	func introduce() {
		print("Hi! My name is \(name)")
	}
}
```

## Keywords
+ User-defined Data Type
+ Value Type
+ Mutating

## References
- [구조체(Struct)와 클래스(Class) 완전 정복하기](https://mini-min-dev.tistory.com/117)
- [스위프트 UI가 Struct를 사용하는 이유](https://code-algo.tistory.com/161)