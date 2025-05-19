>[!question]
>GQ1. 프로토콜 지향 프로그래밍(POP)이란 무엇일까?
>GQ2. 프로토콜 지향 프로그래밍을 어디에 사용하는 걸까?
## Description
- Swift는 프로토콜 지향 언어(Protocol-Oriented Language)이다.
- 프로토콜이란 특정 기능에 필요한 메소드, 프로퍼티 등을 정의만 해놓은 것이다.
- 프로토콜 지향 프로그래밍은 필요한 부분만을 프로토콜로 분리하여 프로그래밍을 하는 것이다.
- 
- ### OOP(객체 지향 프로그래밍)의 단점
	1. **SuperClass**에 종속적이다.
		- Subclassing을 하여 사용하기 위해서는 superclass의 코드를 알고 있어야 한다.
		- 서브클래스는 불필요한 변수화 함수를 상속받을 수 없다.
		- 예) `Animal` 클래스를 상속받은 `Fish` 클래스가 `Walk()`함수를 가지는 경우. 물고기가 걷지 않는데도 불구하고 해당 함수를 갖는다.
	2. **Value Type**을 사용할 수 없다.
		- 참조 타입은 참조 추적에 비용이 많이 발생한다. 하지만 상속을 사용하기 위해서는 값 타입으로 정의해도 무방한 모델들을 굳이 참조 타입으로 정의해야 한다.
	
- ### PDP의 장점
	- SuperClass에 독립적
	- 값 타입 사용 가능
	- 값 타입 사용 시, 상속을 할 수 없으므로 매번 기능을 다시 구현해야 하는 한계 극복
	- 기능의 모듈화 가능
	- 불필요한 API를 제외하고 정의한 API만 가져올 수 있음

## 주요 기능
+ 프로토콜 정의
+ 프로토콜을 채택한 구조체 및 클래스 정의
+ 프로토콜의 메소드 호출
+ `Extension`을 이용한 초기구현

## 코드 예시

### 프로토콜 정의
1. `Talkable`이라는 프로토콜을 정의한다.
```swift
protocol Talkable {
	var topic: String { get set }
	func talk(to: Self)
}
```
2. `Talkable` 프로토콜을 채택한 구조체를 정의한다.
```swift
struct Person: Talkable {
	var topic: String
	var name: String
	
	func talk(to: Person) {
		print("\(topic)에 대해 \(to.name)에게 이야기합니다.")
	}
}
```
`Person` 구조체는 `Talkable` 프로토콜을 채택하고 있다. 프로토콜을 채택하고 있으므로 해당 프로토콜이 가지는 내부 프로퍼티와 메소드를 반드시 구현해야 한다. `Talkable`을 채택한 `Person`클래스는 `talk(to:)`메소드를 사용할 수 있다.

3. 프로토콜의 메소드를 호출한다.
```swift
let elly = Person(topic: "Swift", name: "elly")
let coco = Person(topic: "Java", name: "Coco")

elly.talk(to: coco)
coco.talk(to: elly)
```
`Person`의 내부 코드를 알지 못하더라도, `Talkable`을 채택하고 있으니 `talk(to:)` 메소드를 호출할 수 있다.

4. 여러 개의 프로토콜을 추가한다.
```swift
protocol Eatable {
	func eat()
}

protocol Moveable {
	func run()
	func walk()
}

struct Person: Talkable, Eatable, Moveable {
	var topic: String
	var name: String
	
	func talk(to: Person) {}
	func eat(){}
	func run(){}
	func walk(){}
}
```
**이렇게 필요한 기능은 프로토콜로 묶음으로써 기능의 모듈화가 가능해진다.**

5. `Person` 뿐만 아니라 다른 타입도 `Talkable` 프로토콜을 채택할 수 있다.
```swift
struct Monkey: Talkable {
	var topic: String
	
	func talk(to: Monkey) {
		print("우끼끼 꺄꺄 \(topic)")
	}
}
```
그런데 `Talkable`을 채택하는 구조체가 많아 질수록 매번 `talk(to:)`를 구현해야 하는 불편함이 존재한다.

### 프로토콜 추기구현
이때 `Extension`을 사용한다. 
5. 프로토콜을 초기 구현한다.
```swift
extension Talkable {
	func talk(to: Self) {
		print("\(to)! \(topic)")
	}
}
```
6. 구현없이 프로토콜의 메소드를 호출한다.
```swift
struct Person: Talkable {
	var topic: String
	var name: String
}
	
struct Monkey: Talkable {
	var topic: String
}
	
let elly = Person(topic: "swift", name: "elly")
let hana = Person(topic: "Internet", name: "hana")

elly.talk(to: hana)
hana.talk(to: elly)
```
이런 식으로 하나의 프로토콜을 만들고, 초기 구현을 해둔다면 여러 타입에서 해당 기능을 사용하고 싶을 때 프로토콜을 채택하기만 하면된다.

만약, 프로토콜의 초기 구현과 다른 동작을 원한다면, 프로토콜의 요구사항을 재정의하면 된다.
```swift
struct Monkey: Talkable {
    var topic: String
    func talk(to: Monkey) {
        print("\(to)! 우끼기기기끼기기")
    }
}
```

### `class`에서도 사용 가능하다.
```swift
protocol Workable {
	func work()
}

protocol Eatable {
	func eat()
}

protocol Sleepable {
	func sleep()
}

class Human: Workable, Eatable, Sleepable {
	func work() {
		// 사람이 일함
	}
	
	func eat() {
		// 사람은 밥 먹음
	}
	
	func sleep() {
		// 사람은 잠도 잠
	}
}

class Robot: Worable {
	func work() {
		// 로봇은 일 함
	}
	// 로봇은 밥 안 먹고 잠 안 자므로 Eatable과 Sleepable은 안 써도 됨
}
```

## Keywords
- **프로토콜**
- **프로토콜 지향 프로그래밍**
- 객체지향 프로그래밍
+ 구조체
+ 클래스
+ Extension

## References
- [블로그](https://velog.io/@ellyheetov/Protocol-Oriented-Programming)
- [루미님의 좋은 코드 만들기]![[Lumi_좋은_코드_만들기.pdf]]