>[!question]
>GQ1. ViewModel은 왜 쓰는걸까
>GQ2. #Published 는 어떻게 쓰일까?

## Description
### Definition
- **MVVM이란?**
	- 소프트웨어 개발을 위한 아키텍처 패턴으로, 애플리케이션의 코드 구조를 명확하게 분리하고 유지 보수성을 높이며 테스트를 용이하게 할 수 있도록 하는 디자인 패턴이다.
	- 기능에 따라 Model-View-ViewModel로 나누어지며, 각 컴포넌트가 역할을 가지고 유기적으로 동작하며 의존성을 줄이는데 목적이 있다.
- **ViewModel이란?**
	- **ViewModel**은 SwiftUI에서 **뷰와 모델 사이를 중재**하는 역할을 수행하는 컴포넌트이다.
	- **사용자의 입력을 처리하고**, 필요한 경우 모델을 업데이트하며, 그 상태를 다시 뷰에 전달해 **UI를 동기화**한다.
	- SwiftUI에서는 ViewModel을 보통 ObservableObject 프로토콜을 채택한 클래스로 구현한다.
	- 뷰는 ViewModel을 @ObservedObject, @StateObject 등의 속성 래퍼로 관찰하며, ViewModel 내부의 상태(@Published)가 변경되면 뷰가 자동으로 갱신된다.
- **@Published란?**
	- ObservableObject 프로토콜을 채택하여 상태변화를 감지한다.
	- Model의 원시 데이터를 View에 적용하기 위해 형식 변환, 필터링, 정렬 등의 가공 과정을 거친다.
### Syntax
```swift
class JoidViewModel: ObservableObject {
    @Published var someState: Int = 0
    
    func updateState() {
        someState += 1
    }
}
```
- ObservableObject를 채택해야 뷰에서 이 객체의 상태를 관찰할 수 있다.
- @Published 속성은 상태 변화를 broadcast하여 뷰에 알린다.
## 주요 기능
#### **상태 보존 및 로직 분리**
- ViewModel은 뷰의 **상태와 비즈니스 로직을 분리**할 수 있게 하여, **재사용성과 테스트 용이성**을 높여준다.
#### **뷰와의 연결**
- 뷰에서 ViewModel을 @ObservedObject, @StateObject 등의 속성 래퍼로 주입받아 상태를 관찰한다.
	- @ObservedObject: 외부에서 생성된 ViewModel 주입 시 사용
    - @StateObject: 뷰에서 직접 ViewModel을 생성하고 상태를 유지할 때 사용
#### **모델과의 연결**
- ViewModel은 종종 모델(예: 서버에서 가져온 데이터, DB 등)과 통신하며, 이를 가공해 뷰에 전달하는 역할을 한다.

## 코드 예시

#### MVVM 코드 예제
```swift
import SwiftUI

/// Model
struct Counter {
    var value: Int
}

/// ViewModel
class JoidCounterViewModel: ObservableObject {
    @Published private(set) var counter = Counter(value: 0)

    func increment() {
        counter.value += 1
    }

    func reset() {
        counter = Counter(value: 0)
    }
}

struct JoidCounterView: View {
    @StateObject private var vm = CounterViewModel()

    var body: some View {
        VStack{
            Text("현재 값: \(vm.counter.value)")
                .font(.largeTitle)

            Button("1 증가") {
                vm.increment()
            }

            Button("리셋") {
                vm.reset()
            }
        }
        .padding()
    }
}

#Preview {
    CounterView()
}
```
## Keywords
+ [[MVVM]]
+ [[@Published]]
+ [[상태관리]]
## References
-  [SwiftUI ObservableObject 공식문서](https://developer.apple.com/documentation/combine/observableobject)
- [Velog MVVM 설명](https://velog.io/@newon-seoul/MVVM-도입기)