>[!question]
>GQ1. 애니메이션과 트랜지션의 차이는 무엇일까?
>GQ2. 트랜지션에는 어떤 종류가 있을까?

## Description

- 트랜지션은 뷰 계층 구조에 새로운 뷰가 추가되거나 기존에 있던 것이 제거될 때 적용되는 애니메이션의 한 종류이다.
- 뷰를 이동할 때보다는 **뷰를 보여지게 할 때와 사라지게 할 때의 애니메이션**

### Transition의 종류

> `AnyTransition` 프로토콜을 따르고 있다.

1. `.slide`: 슬라이드하면서 등장하거나 사라짐
2. `.move(edge:)`: 특정 가장자리에서 이동
3. `.opacity`: 투명도 변화
4. `.scale`: 확대/축소 효과
5. `.asymmetric(insertion:removal:)`: 보여질 떄와 사라질 때 다른 애니메이션 적용
6. `.combined(with:)`: 다른 트랜지션 효과와 같이 사용

- 각 트랜지션은 `.animation()`으로 트랜지션에 대한 애니메이션을 설정할 수 있다.

## 주요 기능

- 기본적으로 애니메이션과 함께 사용되어야 한다.
- `if`, `switch`, `ForEach`에서 아이템의 변동 등 뷰가 나타나거나 사라질 때 사용할 수 있다.

```Swift
@State var isShowing = false

if isShowing {
    Text("Transition Test")
        .transition(.slide)
}

Button("Show") {
    withAnimation {
        isShowing.toggle()
    }
}
```

## 코드 예시

```Swift
import SwiftUI

enum LemonTransitionType: String, CaseIterable, Identifiable {
    case opacity = "opacity"
    case slide = "slide"
    case moveLeading = "move(edge: .leading)"
    case moveTrailing = "move(edge: .trailing)"
    case scale = "scale"
    case asymmetric = "asymmetric(insertion: .scale, removal: .opacity)"

    var id: String { rawValue }

    var transition: AnyTransition {
        switch self {
        case .opacity:
            return .opacity
        case .slide:
            return .slide
        case .moveLeading:
            return .move(edge: .leading)
        case .moveTrailing:
            return .move(edge: .trailing)
        case .scale:
            return .scale
        case .asymmetric:
            return .asymmetric(insertion: .scale, removal: .opacity)
        }
    }
}

struct LemonTransitionView: View {
    @State private var isShowing = true

    var body: some View {
        ScrollView {
            ForEach(LemonTransitionType.allCases) { type in
                LemonTextTransitionView(
                    name: type.rawValue,
                    transition: type.transition
                )
                .padding()
            }
        }
        .padding()
    }
}

struct LemonTextTransitionView: View {
    var name: String = ""
    var transition = AnyTransition.opacity

    @State private var isShowing = true
    var body: some View {
        VStack {
            Text("\(name)")
                .font(.headline)
                .padding()
            if isShowing {
                HStack {
                    Text("Hello")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                .transition(transition)
            }
            Button("Show") {
                withAnimation(.easeInOut) {
                    isShowing.toggle()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            .background.secondary,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}

#Preview {
    LemonTransitionView()
}

```

## Keywords

- [[Animation]]

## References

- [Animating views and transitions – SwiftUI Tutorials | Apple Developer Documentation](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)
- [Transition, AnyTransition 사용 방법 (slide, move, scale, opacity, asymmetric)](https://ios-development.tistory.com/1144)