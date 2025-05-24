>[!question]
>GQ1. NavigationView는 무엇인가?
>GQ2. NavigationView를 사용하지 않는 이유는 무엇인가?


![[NavigationViewImg.png]]
## Description
- NavigationView는 iOS 13.0부터 도입된 SwiftUI의 기본적인 네비게이션 구조를 제공하는 뷰이다. 다만 16부터는 NavigationStack을 사용하기를 권장하고 있음. 
- [Navigation Migration 공식 문서](https://developer.apple.com/documentation/swiftui/migrating-to-new-navigation-types)의 내용에 따르면 NavigationView는 단일 구조로 단일 컬럼, 다중 컬럼을 모두 처리하려 했기에 복잡했고 일관성이 부족했다. 
		- 단일 구조: 화면을 구성하는 뷰 계층 구조가 한 컨테이너 안에 다 들어있는 형태
		- 단일 컬럼: 한번에 하나의 뷰만 보이는 구조
		- 다중 컬럼: 한 화면에 여러 컬럼으로 나눠 동시에 여러 구조를 보여 주는 구조(Mac, IPad 등)
	- NavigationStack -> 스택 기반 탐색(push/pop)
	- NavigationSplitView -> 다중 컬럼 탐색
- NavigationView는 Stack을 통제할 수 없어 복잡한 이동 흐름을 구현할때 UIKit을 사용해야 했음.


## 주요 기능
+ SwiftUI 앱에서 뷰간 push 방식 탐색을 가능하게 해주는 기본 컨테이너.
+ 자동으로 상단에 NavigationBar을 추가해줌.
	+ 제목 (.navigationTitle("제목"))
	+ 왼쪽/오른쪽 버튼(.navigationBarItems(leading: ..., trailing: ...))

## 코드 예시
일반 예시
```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("메인 화면입니다")
                NavigationLink("상세 화면으로 이동") {
                    DetailView()
                }
            }
            .navigationTitle("홈") // 탐색 바 제목
            .navigationBarItems(
                leading: Button(action: {
                    print("왼쪽 버튼 눌림")
                }) {
                    Image(systemName: "line.horizontal.3")
                },
                trailing: Button(action: {
                    print("오른쪽 버튼 눌림")
                }) {
                    Image(systemName: "gear")
                }
            )
        }
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text("상세 화면입니다")
        }
        .navigationTitle("상세 화면")
    }
}
```


탐색을 위한 컨테이너로 사용할 경우
```swift
NavigationView {
    List {
        NavigationLink("Detail", destination: DetailView())
    }
}
```

다중 컬럼 사용시
```swift
NavigationView {
    SidebarView()
    ListView()
    DetailView()
}
```

## Keywords
+ [[View]]
+ [[Navigation]]
+ [[NavigationStack]]

## References
- GPT
- [Apple 공식 문서](https://developer.apple.com/documentation/swiftui/navigationview)