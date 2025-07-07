>[!question]
>GQ1. - MVVM은 뭐지?
>GQ2. - Model은 뭐지?
>GQ3. - View는 뭐지?
>GQ4. - ViewModel은 뭐지?
>GQ5. - 왜 MVVM으로 나눠 놓았지?
>GQ6. - MVVM을 사용할 때 쓰이는 Property Wrapper들은?

## Description
### MVVM이란?

MVVM은 앱 구조를 세가지로 나누는 아키텍처이다.

- Model: 데이터와 비즈니스 로직
- View: 사용자에게 보여지는 UI
- ViewModel: Model과 View 사이에서 데이터를 가공하거나 상태를 관리하는 중간 역할

### MVVM을 쓰는 이유

- 코드 역할 분리가 잘 됨
- 테스트와 유지보수가 쉬워짐
- SwiftUI의 데이터 바인딩 구조(@State, @Publish)등과 잘 어울림
### MVVM의 단점

- 초기 구조 설계가 복잡함
- ViewModel이 비대해질 수 있음
- 초보자에게 개념이 어려움

### MVVM을 사용할 때의 Property Wrapper들

|Property Wrapper|사용 위치|기능|MVVM에서의 역할|
|---|---|---|---|
|@State|View 내부|View 내부에서 상태 저장 (값 타입)|View 전용 상태 (ex 입력값)|
|@Binding|자식 View|부모의 상태를 공유|부모 View의 State를 자식 View에 넘길 때|
|@ObservedObject|View|외부 상태의 객체 감지|View가 ViewModel을 관찰|
|@StateObject|View|View에서 직접 생성한 ViewModel 감지|View가 ViewModel을 소유|
|@Published|ViewModel|값 변경 시 View에 알림|ViewModel → View로 데이터 전달|

#### @StateObject와 @ObservedObject의 차이

ViewModel을 누가 생성하고, 누가 생명주기를 관리하느냐의 차이가 있다.

@StateObject는 ViewModel을 View 내부에서 생성하고 생명주기를 관리한다.

반면, @ObservedObject는 View 외부에서 생성하고 생명주기를 관리한다.

@ObservedObject는 상위뷰의 상태값이 변경되었을 때, 초기화 되지만, @StateObject는 초기화 되지 않고, ObservableObject 객체를 가지고 있는 뷰의 생명주기 동안 상태를 유지한다.

그러므로, ViewModel을 생성할 때에는 @StateObject를 사용하고, 해당 객체를 하위뷰에서 사용할 때에는 @ObservedObject를 사용하자.

#### ObservableObject란?

ObservableObject는 SwiftUI의 View가 외부 객체의 상태 변화를 감지하게 할 수 있는 프로토콜이다.

ViewModel의 값이 바뀔 때 View도 자동으로 바뀌게 하려면 이걸 꼭 써야한다.

그리고 그 객체는 class여야 한다.

## 코드 예시
### Model

```swift
struct Todo: Identifiable { // Model
	let id: UUID
	var title: String
	var isDone: String
}
```

### ViewModel

```swift
class TodoViewModel: ObservableObject { // ViewModel
	@Published var todos: [Todo]= []
	
	func addTodo(title: String) {
		let newTodo = Todo(title: title, isDone: false)
		todos.append(newTodo)
	}
}
```

### View

```swift
struct TodoView: View { // View
    @StateObject var viewModel = TodoViewModel()
    @State private var newTodoTitle = ""

    var body: some View {
        
        VStack {
            
            HStack {
                TextField("할 일 입력", text: $newTodoTitle)
                
                Button {
                    viewModel.add(title: newTodoTitle)
                    newTodoTitle = ""
                } label: {
                    Text("추가")
                }
            }

            List {
                ForEach(viewModel.todos) { todo in
                    HStack {
                        Text(todo.title)
                        Spacer()
                        Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                viewModel.toggleTodo(todo)
                            }
                    }
                }
            }
        }
        .padding()
        
    }
}
```

### ObservedObject vs StateObject
```swift
extension CountView {
    final class ViewModel: ObservableObject {
        @Published var count: Int = 0
        
        func increase() { count += 1 }
    }
}

struct CountView: View {
    @Binding var parentCount: Int
    @ObservedObject var viewModel = ViewModel()
//    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("CountView's Count is \\(viewModel.count)")
            
            Button(action: {
                viewModel.increase()
            }, label: {
                
                Text("Add Count")
            })
            
            Text("ParentView's Count is \\(parentCount)")
            
            Button(action: {
                parentCount += 1
            }, label: {
                
                Text("Add Count")
            })
        }
    }
}

struct ParentView: View {
    @State private var count: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("ParentView's count is \\(count)")
                NavigationLink {
                    CountView(parentCount: $count)
                } label: {
                    Text("Navigate to CountView")
                }
            }
        }
    }
}
```
## Keywords

- [[Model]]
- [[View]]
- [[ViewModel]]
- [[Property Wrapper]]
- [[Architectural Patterns]]

## References

- [StateObject와 ObservedObject의 차이점]([https://velog.io/@syong_e/SwiftUI-ObservedObject-와-StateObject-차이점](https://velog.io/@syong_e/SwiftUI-ObservedObject-%EC%99%80-StateObject-%EC%B0%A8%EC%9D%B4%EC%A0%90))
