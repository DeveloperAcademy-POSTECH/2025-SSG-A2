>[!question]
>GQ1. Class는 뭐지?

## Description
### Class의 정의
Class는 User-defined Data Type 중 하나를 일컫는다.
Reference Type이다. Value Type과 구별된다.
Class는 Struct와 달리 무조건 init을 만들어 써야한다. 이는 class가 inheritance가 가능하고, 초기화 과정이 더 복잡하고 엄격하기 때문이다.

## 주요 기능
### Reference Type
Class는 Value Type과 Reference Type중 Reference Type에 해당한다.
Reference Type은 복사하면 같은 인스턴스 주소를 참조한다.
### Heap에 저장
주소로 관리되는 Heap에 저장한다. Stack보다 속도가 느리지만 유연하다. ARC로 관리된다.
다만, 순환참조가 발생할 우려가 있다.
### Inheritance
상속이라고 한다. 객체지향 프로그램(OOP)의 핵심 개념이다.
한 클래스가 다른 클래스의 프로퍼티와 메소드를 물려받는 기능이다.
부모 클래스가 자식 클래스에게 물려주는 것이다.
class만 상속이 가능하다.
## 코드 예시
```swift
class User {
	var name: String

	init(name: String) {
		self.name = name
	}

	func sayHello() {
		print("Hello, I'm \(name)!")
	}
}
```

## Keywords
+ Object-Oriented Programming
+ User-defined Data Type
+ Value Type
+ Inheritance