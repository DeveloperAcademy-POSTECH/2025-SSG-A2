

>[!question]
>- [x] @Bindable은 뭐지?
>- [x] @Bindable은 정말 단순히 Binding 타입을 쓰기 위해서 있는 것인가?
# Description
@Binding은 @Observable 모델을 SwiftUI 뷰에서 $ 바인딩 가능하게 만들어주는 property wrapper이다.
예를 들면 TextField, Toggle, Slider 등에서 바인딩 타입을 쓸 때 사용한다.
# 코드 예시
```swift
struct ContentView: View {
	@Bindable private var userModel: UserModel
}
```
### [[@Environment]]과 [[@Bindable]]을 써서 뷰모델을 앱 전체에서 공유하는 법

여기에서 @Bindable을 

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
- [[@Observable]]
# References
- [@Bindable](https://developer.apple.com/documentation/swiftui/bindable)
