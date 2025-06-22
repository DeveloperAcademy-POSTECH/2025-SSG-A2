
>[!question]
>- [x] 바인딩은 뭐지?
>- [x] 바인딩은 어떻게 사용하지?
>- [x] 바인딩은 왜 사용하지?
# Description
Binding은 참조형 값처럼 작동하는 구조체이다.
SwiftUI에서 @State는 뷰의 지역 상태를 소유하며, 이 상태가 변경되면 뷰가 다시 렌더링된다.
반면 @Binding은 다른 곳에 있는 상태 값을 읽고 쓸 수 있는 통로이다.
@Binding은 외부 상태 값을 제어할 수 있는 '얕은 참조'를 래핑한 구조체이다.
### @State와 @Binding과의 차이
- @State는 실제 값을 보관
- @Binding은 그 값에 접근하고 변경
### 사용 예시
아래 코드에서 $count는 Int 타입이 아닌 `Binding<Int>` 타입이다. '<>' 문법은 [[Generic]] 문법이다.
```swift
@State private var count: Int = 0
MyStep(value: $count)
```
### $ 이란?
여기서 $는 @State 또는 다른 property wrapper에서 바인딩 객체를 만들어주는 [[Syntactic Sugar]]라고 한다.
여기서 syntactic sugar는 프로그래밍에서 더 읽기 쉽고 쓰기 쉬운 표현을 제공하는 문법이다.
### 더 깊게. 바인딩은 어떻게 구성되어 있을까?
다음과 같이 구성되어 있다.
```swift
public struct Binding<Value> {
	public var wrappedValue: Value {
		get { get() }
		nonmutating set { set(newValue) }
	}
	let get: () -> Value
	let set: (Value) -> Void
}
```
nonmutatinc이 들어간 이유 -> 구조체는 기본적으로 값을 수정하면 mutating 키워드가 필요하다. 하지만, 여기서는 wrappedValue를 설정해도 실제로는 구조체 자신이 아니라 외부 상태(set 클로저 호출)를 바꾸는 거라서 nonmutating으로 선언한다.
### 바인딩을 사용하면 어떻게 될까?
아래에서 \_count가 되는 이유는 property wrapper를 씌운 변수는 \_를 붙이고 저장되기 때문이다.
```swift
// 아래와 같은 코드를 사용하면?
@Binding var count: Int
count = 6 // = _count.wrappedValue = 6

// 내부에서는 아래와 같이 동작한다.
var _count: Binding<Int>
var count: Int {
	get { _count.wrappedValue }
	set { _count.wrappedValue = newValue }
}

_count.set(6)
```
### 아직도 어렵다면 참고자료
아래와 같이 Property wrapper 없이도 쓸 수 있다.
```swift
import SwiftUI

struct ParentView: View {
	@State private var count = 0

	var body: some View {
		ChildView(
			countBinding: Binding(
				get: { self.count }
				set: { self.count = $0 }
			)
		)
	}
}

struct ChildView: View {

	let countBinding: Binding<Int>

	var body: some View {
		Text("\(countBinding)")
	}

}
```

# Keywords
- [[@State]]
- [[Generic]]
- [[Getter & Setter]]
# References
- 
