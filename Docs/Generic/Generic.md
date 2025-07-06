>[!question]
>GQ1. Swift에서 Generic을 사용하는 방법은 무엇일까?
>GQ2. Swift와 다른 언어의 Generic을 사용할 때의 차이점은 무엇일까?
>GQ3. `associatedtype`은 무엇이고 언제 사용할까?

## Description

Generic은 타입에 의존하지 않고 **다양한 타입에서 재사용**할 수 있는 코드를 작성할 수 있도록 해준다.

### Swift와 다른 언어의 Generic 차이점

구조체나 열거형과 같은 값 타입에서도 Generic을 사용할 수 있다.

## 주요 기능

### GenericFunctions

다양한 타입에 대해 함수를 사용하도록 할 때 Generic을 사용한다.

```Swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoValues(&someInt, &anotherInt)
// someInt is now 107, and anotherInt is now 3

var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)
// someString is now "world", and anotherString is now "hello"
```

타입 T는 실제로 함수가 호출될 때 결정된다.

### 타입 매개변수

위 코드에서의 `<T>`처럼 여러 타입을 대체할 타입을 지정할 수 있다.

일반적으로 `T`, `U`, `V`를 사용하지만 `Dictionary<Key, Value>`과 같이 타입에 대해 이름을 지정할 수 있다. 이름을 작성할 때는 UpperCamelCase를 사용한다.

### Generic Types

Generic을 클래스, 구조체, 열거형에서 사용하는 경우

Generic Functions와 달리 인스턴스를 생성할 때 `<>` 타입을 지정해서 생성해야 한다.

```Swift
struct Stack<Element> {
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
// the stack now contains 4 strings
```

### Generic Type 확장

`extension`을 사용하여 Generic Type을 확장할 수 있다.

```Swift
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}
// Prints "The top item on the stack is tres."
```

### Type Constraints

타입 매개변수으로 사용할 타입을 제한할 수 있다.

```Swift
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
// doubleIndex is an optional Int with no value, because 9.3 isn't in the array
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
// stringIndex is an optional Int containing a value of 2
```

### Associated Types

`protocol`에서 Generic을 사용할 때는 `associatedtype`으로 범용 타입을 지정하여 사용할 수 있다.

```Swift
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // conformance to the Container protocol
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
```

`associatedtype`에도 제약을 적용할 수 있다.

```Swift
protocol Container {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
```

### Generic Where Clauses

`associatedtype`에 대한 추가적인 제약을 적용할 때 사용한다. 아래 예시에서는 `C1`, `C2`에 대해 같은 `associatedtype`인 `Item`을 가져야 하고, `Item`이 `Equatable`을 따라야 한다는 제약 사항을 추가한 것이다.

```Swift
func allItemsMatch<C1: Container, C2: Container>
        (_ someContainer: C1, _ anotherContainer: C2) -> Bool
        where C1.Item == C2.Item, C1.Item: Equatable {

    // Check that both containers contain the same number of items.
    if someContainer.count != anotherContainer.count {
        return false
    }

    // Check each pair of items to see if they're equivalent.
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }

    // All items match, so return true.
    return true
}
```

### Extensions with a Generic Where Clauses

Generic이 특정 제약을 만족할 때 사용할 수 있는 메서드를 확장할 수 있다.

```Swift
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
```

## 코드 예시

```Swift
import SwiftUI

private protocol LemonGenericStack {
    associatedtype Item
    var count: Int { get }
    mutating func push(_ item: Item)
    mutating func pop() -> Item?
}

private struct LemonGenericStackInt: LemonGenericStack {
    private var items: [Int] = []

    var count: Int { items.count }

    mutating func push(_ item: Int) {
        items.append(item)
    }

    mutating func pop() -> Int? {
        return items.popLast()
    }
}

private struct LemonGenericStackDouble: LemonGenericStack {
    private var items: [Double] = []

    var count: Int { items.count }

    mutating func push(_ item: Double) {
        items.append(item)
    }

    mutating func pop() -> Double? {
        return items.popLast()
    }
}

private func LemonGenericStackEqualSize<
    Stack1: LemonGenericStack,
    Stack2: LemonGenericStack
>(_ someStack: Stack1, _ anotherStack: Stack2) -> Bool
where Stack1.Item == Stack2.Item {
    someStack.count == anotherStack.count
}

struct LemonGenericView: View {
    @State private var float1: Float = 1.0
    @State private var float2: Float = 2.0

    @State private var stack1: LemonGenericStackInt = LemonGenericStackInt()
    @State private var stack2: LemonGenericStackInt = LemonGenericStackInt()
    @State private var stack3: LemonGenericStackDouble =
        LemonGenericStackDouble()

    var body: some View {
        VStack {
            VStack {
                Text("Generic Function")
                    .font(.headline)
                    .padding(.bottom)

                VStack {
                    Text("float1: \(float1)")
                    Text("float2: \(float2)")
                }
                .padding(.bottom)

                Button("Swap") {
                    swap(&float1, &float2)
                }
            }
            .padding()
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 16)
            )

            VStack {
                Text("Generic Where Clauses")
                    .font(.headline)
                    .padding(.bottom)

                HStack {
                    VStack {
                        Text("stack1(Int): \(stack1.count)")
                        Button("Push") {
                            stack1.push(0)
                        }
                        Button("Pop") {
                            _ = stack1.pop()
                        }
                    }

                    VStack {
                        Text("stack2(Int): \(stack2.count)")
                        Button("Push") {
                            stack2.push(0)
                        }
                        Button("Pop") {
                            _ = stack2.pop()
                        }
                    }

                    VStack {
                        Text("stack3(Double): \(stack3.count)")
                        Button("Push") {
                            stack3.push(0)
                        }
                        Button("Pop") {
                            _ = stack3.pop()
                        }
                    }
                }

                Text(
                    "Equal size: \(LemonGenericStackEqualSize(stack1, stack2))"
                )

                // Global function 'LemonGenericStackEqualSize' requires the types 'Int' and 'Double' be equivalent
                // Text("Equal size: \(LemonGenericStackEqualSize(stack1, stack3))")
            }
            .padding()
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 16)
            )
        }
    }

    private func swap<T>(_ a: inout T, _ b: inout T) {
        let temp = a
        a = b
        b = temp
    }
}

#Preview {
    LemonGenericView()
}
```

## Keywords

- [[Extension]]

## References

- [Generics | Documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/generics)
- [Swift - 제네릭 (Generic) 완전 정복하기](https://mini-min-dev.tistory.com/262)