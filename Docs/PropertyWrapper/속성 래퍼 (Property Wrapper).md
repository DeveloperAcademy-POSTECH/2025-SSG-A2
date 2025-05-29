>[!question]
>GQ1. SwiftUI에서 가장 많이 쓰는 속성 래퍼는 뭐고 왜 쓰는걸까?
>GQ2. #Property_Wrapper 의 종류는 무엇이 있을까?

## Description
### Definition
- **프로퍼티 래퍼**는 속성(변수나 상수)에 **저장 방식이나 동작 로직을 래핑해서 재사용 가능**하게 해주는 Swift의 기능이다.
- **@WrapperName** 형식으로 사용되며, **속성 앞에 붙여 해당 속성의 동작을 변경**한다.
- 반복적인 속성 로직(값 검증, 값 저장 방식, UserDefaults 연동 등)을 캡슐화하는데 사용된다.
- SwiftUI에서는 **상태 관리**를 위한 핵심 기능으로 사용된다.
### Syntax
```swift
@propertyWrapper
struct WrapperName {
    var wrappedValue: ValueType
}

@WrapperName var myValue: ValueType
```
- @WrapperName가 자동으로 wrappedValue를 관리한다.
- 필요한 경우 projectedValue($변수이름)도 같이 제공 가능하다.
## 주요 기능
#### @State
- **뷰 내부에서 상태를 저장하고, 그 값이 바뀌면 뷰를 자동으로 다시 그리게 만드는 속성 래퍼이다.**
- State가 선언된 해당 뷰 내부에서 **값을 직접 소유하고 관리**하며, 값이 변경되면 해당 뷰의 body를 다시 계산해서 UI를 갱신한다.
- 따라서 뷰 내부에서만 변경되어야 하는, 즉 **뷰 자체적으로만 사용하는 상태**일 경우에 사용한다.
#### @Binding
- **다른 뷰의 State를 참조해서 공유하고, 그 값을 읽고 쓸 수 있게 해주는 프로퍼티 래퍼이다.**
- 상태를 해당 뷰에서 **소유**하지 않고, 다른 뷰에 있는 **상태를 연결**해서 조작하려 할 때 사용된다.
#### @ObservedObject
- **외부의 상태 객체(ex. ViewModel) 을 observe해서 값이 변경될 때 뷰를 자동으로 업데이트 해주는 프로퍼티 래퍼이다.**
- 상태가 여러 뷰에서 공유될 때 사용하며, ViewModel 같은 **observable 객체**를 뷰에 주입해서 사용하고 싶을 때 이용한다.
#### @StateObject
- **@StateObject는 SwiftUI 뷰가 직접 소유하고 생성하는 ObservableObject를 관리할 때 사용하는 속성 래퍼이다.**
- 뷰가 ViewModel을 **직접 생성하고**, 그 ViewModel의 **상태와 로직을 해당 뷰의 라이프사이클 동안 유지하고 싶을 때** 사용한다.
- 따라서 @ObservedObject와는 달리, @StateObject는 View가 **직접 ViewModel을 생성**하며, 해당 View가 **생명주기(lifecycle) 내에 있는 동안** ViewModel의 **상태가 보존된다**.
  즉, View가 다시 로드되더라도 **새로운 ViewModel이 생성되지 않고**, 기존 객체가 유지된다.

## 코드 예시
#### @State
```swift
import SwiftUI

struct Week1AnnotationView: View {
	@State var count = 0

	var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(.yellow)
                VStack {
                    Text("바인딩뷰랑 원래뷰 둘다 바뀜: \(count)")
                    Button("덧셈") {
                        count += 1
                    }
                }
            }
        }
    }
}
```

#### @Binding
```swift
import SwiftUI

struct Week1AnnotationView: View {
    @State var count = 0

    var body: some View {
        VStack(spacing: 0){
            ZStack {
                Color(.yellow)
                VStack {
                    Text("바인딩뷰랑 원래뷰 둘다 바뀜: \(count)")
                    Button("덧셈") {
                        count += 1
                    }
                }
            }

            Week1ChildrenView(count: $count)
        }
    }
}

struct Week1ChildrenView: View {
    @Binding var count: Int

    var body: some View {
        ZStack(spacing: 0) {
            Color(.green)
            VStack {
                Text("여기는 children 뷰\n여기서 버튼 조작해도 값 바뀜")
                Button("childrenview 버튼") {
                    count += 1
                }
            }
        }
    }
}
```
#### @ObservedObject
 ``` swift
import SwiftUI

class Week1CounterViewModel: ObservableObject {
    @Published var count = 0
}

struct Week1CounterView: View {
    @ObservedObject var viewModel: Week1CounterViewModel

    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Button("Up") {
                viewModel.count += 1
            }
        }
    }
}
/*
@Published는 상태 값이 바뀔 때마다 뷰에 알려주는 “방송기능”을 가진 속성 래퍼로, 보통 ViewModel 안에 쓰이고, @ObservedObject 같은 뷰 쪽 래퍼들이 이 방송을 듣는 구조이다.
*/

 ```
#### @StateObject
 ``` swift
class Week1MyViewModel: ObservableObject {
    @Published var count = 0
}

struct Week1MainView: View {
    var body: some View {
        TabView {
            Week1ScreenA()
                .tabItem {
                    Label("A", systemImage: "1.circle")
                }

            Week1ScreenB()
                .tabItem {
                    Label("B", systemImage: "2.circle")
                }
        }
    }
}

struct Week1ScreenA: View {
    @StateObject private var vm = Week1MyViewModel()

    var body: some View {
        VStack{
            Text("Screen A Count: \(vm.count)")
            Button("Increment") {
                vm.count += 1
            }
        }
        .padding()
    }
}

struct Week1ScreenB: View {
    @StateObject private var vm = Week1MyViewModel()

    var body: some View {
        VStack{
            Text("Screen B Count: \(vm.count)")
            Button("Decrement") {
                vm.count -= 1
            }
        }
        .padding()
    }
}

 ```

## Keywords
+ ViewModel
+ @Published
+ LifeCycle

## References
- https://docs.swift.org/swift-book/documentation/the-swift-programming-language/properties/#Property-Wrappers (SwiftUI 프로퍼티 래퍼 공식문서)