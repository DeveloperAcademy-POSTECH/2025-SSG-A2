

>[!question]
>- [x] Observable은 뭐지?
>- [x] Observable은 왜 새로 생겼을까
>- [x] Observable과 같이 쓰는 Property Wrapper들에는 뭐가 있지?
# Description
- @Observable은 데이터의 변화를 감지하고, 그 변화에 따라 뷰를 자동으로 업데이트해주는 SwiftUI의 상태 관리 도구 중 하나이다.
- 간단히 말하면, 변활 수 있는 데이터를 나타내는 객체이다.
- 추가로, 만약 바인딩 타입이 필요하다면 [[@Bindable]]을 선언할 때 써서 하면 된다.
### 어떤 상황에서 쓰는가?
- 여러 뷰에서 공유해야 하는 데이터가 있을 때
- 데이터가 바뀔 때 자동으로 UI를 업데이트하고 싶을 때
### [[@State]], [[@ObservableObject]]와의 차이는 무엇인가?
| 항목            | `@State`        | `@ObservableObject`                 | `@Observable` (Swift 5.9~)    |
| ------------- | --------------- | ----------------------------------- | ----------------------------- |
| 타입            | 값 타입 (`struct`) | 참조 타입 (`class`)                     | 참조 타입(`class`)                |
| 사용 위치         | 뷰 내부 전용         | 여러 뷰에서 공유할 수 있는 상태                  | 여러 뷰에서 공유할 수 있는 상태            |
| 상태 감지 방식      | 뷰가 직접 소유        | `@Published` 속성을 통해 감지              | 변수 변경을 자동 감지                  |
| SwiftUI 연결 방법 | `@State`        | `@StateObject`, `@ObservedObject` 등 | `@Bindable`을 함께 사용            |
| 바인딩 지원 (`$`)  | 가능              | `@Published` 속성만 가능                 | 가능 (`@Bindable` 통해 직접 바인딩 가능) |
# Code 예제
```swift
@Observable
class UserModel {
	var name: String = ""
	var age: Int = 0
}

struct ContentView: View {
	var user = UserModel()

	var body: some Veiw {
		Text(user.name)
		Text("\(user.age")
	}
}
```
# 왜 새로 추가되었나?
### 코드가 간결해짐
뷰모델에는 [[@ObservableObject]],
뷰모델 객체 안의 속성에는 [[@Published]],
뷰에는 [[@ObservedObject]]를
넣었어야 했는데 이제는 [[@Observable]]과 더 나아가서는 [[@Bindable]]로 가능하다.
### 뷰 업데이트 매커니즘이 좀 더 효율적으로 바뀜
[[@ObservableObject]]에서는 [[@Published]] 프로퍼티가 변하면 뷰가 해당 프로퍼티를 읽고 있지 않아도 뷰가 다시 그려진다.
하지만, [[@Observable]]을 쓰면 뷰가 해당 프로퍼티를 읽고 있을 때에만 다시 그려진다.
### [[@Environment]]과 [[@Bindable]]을 써서 뷰모델을 앱 전체에서 공유하는 법
```swift
// @Observable을 이용하여 뷰모델 정의
@Observable
class UserModel {
	var name: String = "Guest"
	var isLoggedIn: Bool = false
}

// App에서 환경으로 주입하기
@main
struct MyApp: App {
	let userModel = UserModel()
	var body: some Scene {
		WindowGroup {
			ObservableView()
				.environment(userModel) // 환경에 주입
		}
	}
}

// 앱 진입 뷰에서 전역 뷰모델 잘 되나 체크
struct ObservableView: View {
	@Environment(UserModel.self) private var userModel

	var body: some View {
		Text("안녕하세요! \(userModel.name)")
		NavigationLink("테스트 뷰", destination: ObservationTestView())
	}
}

// 전역으로 잘 되는지 체크
struct EditView: View {
	@Environment(UserModel.self) private var userModel

	var body: some View {
		@Bindalbe var userModel = userModel
		TextField("유저 이름", text: $userModel.name)
	}
}
```
# Keywords
- [[@Bindable]]
# References
- [Observable Macro](https://developer.apple.com/documentation/observation/observable())
- [Observable Protocol](https://developer.apple.com/documentation/observation/observable)
- [Observable 매크로에 대한 설명](https://eunjin3786.tistory.com/580)
