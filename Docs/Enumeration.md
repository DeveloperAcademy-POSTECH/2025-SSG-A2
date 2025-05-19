>[!question]
 GQ1. Enumeration이란?  
 GQ2. Enumeration의 중요한 특징은?  
 GQ3. Enumeration을 잘 활용하려면 && 하는 상황은 무엇일까?

## GQ1. Enumeration이란?

#### Description

Enumeration(열거형, enum)은 관련된 값들의 그룹에 대해 하나의 공통 타입을 정의하고, 코드 내에서 이 값들을 타입-세이프(type-safe)하게 사용할 수 있도록 해주는 Swift의 데이터 타입입니다[1](https://bbiguduk.gitbook.io/swift/language-guide-1/enumerations)[3](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/enumerations/)[9](https://blog.logrocket.com/swift-enums-an-overview-with-examples/). 즉, 미리 정의된 값들만 가질 수 있는 변수 타입을 만드는 것이며, 각 값은 case로 구분됩니다.

#### 주요 기능

- 관련된 값들의 집합을 하나의 타입으로 정의 : 타입으로 정의한다는 것은?
- 각 값은 case로 구분
- 타입-세이프하게 값 사용 가능 : type-safe란?
- switch문과 함께 사용 시 모든 경우의 수를 <u>강제적으로 처리</u>하도록 하여 코드의 안전성과 가독성을 높임 
강제적 처리란? -> switch문이 모든 case를 반드시 처리해야만 컴파일이 된다는 것
## GQ2. Enumeration의 중요한 특징은?

#### Description

Swift의 Enumeration은 단순히 값만 나열하는 것이 아니라, 다양한 기능과 확장성을 제공

#### 주요 기능

- **Raw Value(원시값) 지원**: 각 case에 Int, String 등 기본 타입의 값을 할당할 수 있음[2](https://www.tutorialspoint.com/swift/swift_enumerations.htm)[6](https://bugfender.com/blog/swift-enums/)[11](https://www.swiftyplace.com/blog/understanding-swift-enumeration-enum-with-raw-value-and-associated-values).
- **<u>Associated Value(연관값) 지원</u>**: 각 case가 추가적인 값을 가질 수 있어, enum 하나로 다양한 데이터 구조를 표현할 수 있음[4](https://www.dhiwise.com/post/how-to-leverage-swift-enumerations-for-enhanced-code-clarity)[7](https://www.kodeco.com/books/swift-apprentice-fundamentals/v2.0/chapters/16-enumerations)[11](https://www.swiftyplace.com/blog/understanding-swift-enumeration-enum-with-raw-value-and-associated-values). 
```
enum Distance {
    case km(String)      // String 타입의 연관값
    case miles(String)   // String 타입의 연관값
}
var dist1 = Distance.km("Metric System")
print(dist1)  // km("Metric System") 출력

// switch문을 사용한 접근
switch dist1 {
case .km(let value):
    print("킬로미터: \(value)")
}

// if case를 사용한 접근
if case .km(let value) = dist1 {
    print("킬로미터: \(value)")
}

// guard case를 사용한 접근
guard case .km(let value) = dist1 else { return }
print("킬로미터: \(value)")

enum Measurement {
    case temperature(Double, scale: String)  // Double과 String 조합
    case dimensions(width: Int, height: Int, depth: Double)  // Int와 Double 혼용
    case description(title: String, value: Int, unit: String)  // 문자열과 정수 조합
}

let currentTemp = Measurement.temperature(23.5, scale: "Celsius")
let boxSize = Measurement.dimensions(width: 30, height: 45
```
- Raw Value와 Associated Value를 동시 사용하는 것은 불가능. 하지만 `RawRepresentable` 프로토콜를 이용하면 우회적으로 가능.

Associated Value란? : enum의 case에 추가적인 데이터를 함께 저장하는 것. case에 필요한 정보를 동적으로 저장하는 것. 전혀 다른 타입의 값도 Associated Value로 가질 수 있으며, enum을 선언할 때가 아니라 case인스턴스를 생성할 때 값을 지정 되기 때문에 같은 case여도 사용할 때마다 다른 값을 가질 수 있음. <- 이것이 Raw Value와의 차이.

동적(dynamic)이라는 것은? : 정적(static)이라는 것은 컴파일할 때 값이 고정되는 것.

- **메서드, 연산 프로퍼티 추가 가능**: enum 내부에 메서드나 연산 프로퍼티를 정의해 관련 로직을 포함할 수 있음[4](https://www.dhiwise.com/post/how-to-leverage-swift-enumerations-for-enhanced-code-clarity)[11](https://www.swiftyplace.com/blog/understanding-swift-enumeration-enum-with-raw-value-and-associated-values).
- **CaseIterable 프로토콜**: 모든 case를 배열처럼 순회할 수 있음[9](https://blog.logrocket.com/swift-enums-an-overview-with-examples/)[11](https://www.swiftyplace.com/blog/understanding-swift-enumeration-enum-with-raw-value-and-associated-values).
Caselterable이란? : 컴파일러가 자동으로 모든 case를 포함하는 allCases라는 타입 속성을 만든다. 

```
enum Direction: CaseIterable {
    case north, south, east, west
}

for direction in Direction.allCases {
    print(direction)
}
// 출력: north, south, east, west
```

- **타입 안정성**: switch문에서 모든 case를 반드시 처리하도록 강제하여 실수 방지[9](https://blog.logrocket.com/swift-enums-an-overview-with-examples/)[5](https://www.avanderlee.com/swift/enumerations/).
- **확장성**: <u>extension을 통해 기능을 추가할 수 있음</u>[4](https://www.dhiwise.com/post/how-to-leverage-swift-enumerations-for-enhanced-code-clarity).
extension이란? : 이미 정의된 타입(Int, String, Enum, Class 등)에 새로운 기능을 더하는 것. 상속은 클래스에서만 가능하지만, extension은 모든 타입에 적용 가능. 재정의는 불가능.

- **에러 처리, 상태 표현 등 다양한 상황에 활용**: 예외 처리, 네트워크 상태, UI 상태 등 다양한 상황에서 활용됨

## GQ3. Enumeration을 잘 활용하려면 && 하는 상황은 무엇일까?

#### Description
Enumeration을 잘 활용하려면 다음과 같은 상황에서 사용하는 것이 효과적

#### 주요 기능

- **서로 배타적인 상태(상호 배타적 값) 표현**: 예를 들어, 네트워크 상태(loading, success, failure), 교통 신호등(red, yellow, green) 등 <u>하나의 상태만 가질 때</u>[7](https://www.kodeco.com/books/swift-apprentice-fundamentals/v2.0/chapters/16-enumerations).
하나의 상태만 가진다는 건? : 여러 case 중 하나의 case만 가질 수 있다는 것. 한 시점에 오직 하나의 상태만 존재할 수 있고, 동시에 여러 상태가 겹치지 않는다는 것. 마치 월요일과 화요일에 동시에 존재할 수 없는 것처럼.

- **정해진 옵션 중 하나만 선택해야 할 때**: 예를 들어, 방향, 요일, 메뉴 선택 등[1](https://bbiguduk.gitbook.io/swift/language-guide-1/enumerations)[9](https://blog.logrocket.com/swift-enums-an-overview-with-examples/).
- <u>**에러 처리**: 다양한 에러 케이스를 명확하게 분류할 때</u>[6](https://bugfender.com/blog/swift-enums/).
에러 처리한다는 건 뭘까? : 프로그램을 실행하다가 예상치 못한 문제가 생겼을 때(예: 파일이 없음, 네트워크 연결 실패, 잘못된 입력 등) 프로그램이 갑자기 멈추지 않고, 적절하게 대응하는 방법. 예를 들어, 자판기에서 돈이 부족하거나, 재고가 없거나, 잘못된 번호를 눌렀을 때 각각의 상황에 맞게 메시지를 보여주거나, 다시 시도하게 할 수 있다. 

- <u>**API 응답 처리**: 성공/실패 등 결과 타입을 명확하게 표현할 때</u>[6](https://bugfender.com/blog/swift-enums/)[7](https://www.kodeco.com/books/swift-apprentice-fundamentals/v2.0/chapters/16-enumerations).
API응답 처리에 Enum을 쓰는 이유 : 서버로부터 받은 응답이 여러 가지 결과로 나타날 수 있기 때문임. 에러 처리와 비슷한 맥락.

- **switch문을 통한 명확한 <u>분기 처리</u>**: 각 case마다 다른 행동을 해야 할 때[5](https://www.avanderlee.com/swift/enumerations/)[9](https://blog.logrocket.com/swift-enums-an-overview-with-examples/).
분기 처리란? : 프로그램이 어떤 조건이나 값에 따라 여러 갈래(분기) 중 한 가지 길을 선택해서 다른 동작을 하도록 만드는 것을 의미. 즉, 조건, 상황, 값 등에 따라 다르게 동작하도록 하는 것임.
- **연관값을 활용한 복합 데이터 구조 표현**: 하나의 case에 추가 정보를 담아야 할 때, 예를 들어, 서버 응답의 성공/실패와 함께 데이터 또는 에러 메시지를 함께 전달해야 할 때 사용

## Keywords
+ API
+ 에러 처리
+ extention

## References
- 참고한 레퍼런스를 작성 (예 : Apple의 공식 문서)


https://arc-viewpoint.tistory.com/entry/%EC%98%B5%EC%8B%9C%EB%94%94%EC%96%B8%EC%97%90%EC%84%9C-%EC%BD%94%EB%93%9C%EB%A5%BC-%EC%8B%A4%ED%96%89%ED%95%98%EA%B2%8C-%ED%95%B4%EC%A3%BC%EB%8A%94-%ED%94%8C%EB%9F%AC%EA%B7%B8%EC%9D%B8-Execute-Code