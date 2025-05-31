>[!question]
>GQ1. SwiftUI에서 뷰에 애니메이션을 어떻게 적용할까?
>GQ2. 애니메이션에는 어떤 종류가 있을까?

## Description

- 상태 변화에 대해 UI를 업데이트(렌더링) 할 때 그 변화를 부드럽게 시각화한다.
- SwiftUI에서는 뷰의 상태가 A에서 B로 바뀌면 프레임워크가 내부적으로 **두 상태 간의 값을 계산**하여 애니메이션을 수행한다.

### Animation의 종류

1. Timing Curve 애니메이션
	- `linear`: 일정한 속도로 진행되는 애니메이션
	- `easeIn`: 천천히 시작해서 빠르게 끝나는 애니메이션
	- `easeOut`: 빠르게 시작해서 천천히 끝나는 애니메이션
	- `easeInOut`: 천천히 시작해서 빨라졌다가 다시 천천히 끝나는 애니메이션
2. Spring 애니메이션
	- `spring`: 탄성이 있는 듯한 효과를 주는 애니메이션
	- duration과 bounce로 더 쉽게 조절이 가능하다.
3. 고급 애니메이션
	- 반복 애니메이션: `.repeatForever(autoreverses: true)` 사용
	- 지연 애니메이션: `.delay(1)` 사용
	- 커스텀 애니메이션
		- `AnimatableModifier` 프로토콜 사용
		- 커스텀 뷰에 적용하려면 `Animatable` 프로토콜 사용
	- 여러 애니메이션을 복합적으로 사용할 때 `PhaseAnimator`를 사용

## 주요 기능

### 암시적 애니메이션(Implicit Animation)

- 뷰의 상태 변화를 감지하고 `.animation(_:)` 모디파이어를 사용해서 애니메이션을 적용한다.

```Swift
struct ImplicitAnimationView: View {
    @State private var isExpanded = false

    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.blue)
                .frame(width: isExpanded ? 200 : 100,
                       height: isExpanded ? 200 : 100)
                // 상태 변화 시 Animation.easeInOut을 적용
                .animation(.easeInOut(duration: 0.5), value: isExpanded)
            
            Button("Toggle") {
                isExpanded.toggle()
            }
        }
    }
}
```

- 암시적 애니메이션을 적용할 경우 특정 변수의 변화에 따라 애니메이션을 적용하고 싶은 뷰에 모두 `.animation(_:)`을 적용해야 한다.

### 명시적 애니메이션(Explicit Animation)

- `withAnimation(_:)` 클로저를 사용하여 코드 블럭 내의 상태 변경으로 애니메이션을 적용한다.

```Swift
struct ExplicitAnimationView: View {
    @State private var offset: CGFloat = 0

    var body: some View {
        VStack {
            Circle()
                .fill(Color.red)
                .frame(width: 50, height: 50)
                .offset(x: offset, y: 0)
            
            Button("Move Right") {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    offset += 100
                }
            }
        }
    }
}
```

- 명시적 애니메이션의 경우 `withAnimation(_:)`에서 변화되는 변수를 사용하는 모든 뷰에 애니메이션이 적용된다.

## 코드 예시

```Swift
import SwiftUI

struct LemonAnimationView: View {
    @State private var isAnimating: Bool = false

    var body: some View {
        VStack {
            LemonMoveAnimationView(isAnimating: true)
            LemonMoveAnimationView(isAnimating: false)
        }
        .padding()
    }
}

struct LemonMoveAnimationView: View {
    var isAnimating: Bool = false

    @State private var isMoving = false

    var body: some View {
        VStack {
            Text(isAnimating ? "Animation" : "Non-Animation")
                .font(.headline)
            Circle()
                .frame(width: 100)
                .offset(x: isMoving ? 100 : -100)
            Button("Move") {
                if isAnimating {
                    withAnimation(.easeInOut(duration: 1)) {
                        isMoving.toggle()
                    }
                } else {
                    isMoving.toggle()
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
    LemonAnimationView()
}
```

## Keywords

- [[Transition]]
- [[Animatable]]
- [[AnimatableModifier]]
- [[PhaseAnimator]]

## References

- [Animating views and transitions – SwiftUI Tutorials | Apple Developer Documentation](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)
- [SwiftUI animations(애니메이션)](https://declan.tistory.com/33)
- [Controlling the timing and movements of your animations | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/controlling-the-timing-and-movements-of-your-animations)