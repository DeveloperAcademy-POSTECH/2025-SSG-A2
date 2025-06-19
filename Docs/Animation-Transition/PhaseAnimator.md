>[!question]
>GQ1. PhaseAnimator란 무엇일까?
>GQ2. `.phaseAnimator`와 `PhaseAnimator`의 차이는 무엇이고 언제 사용할까?
>GQ3. PhaseAnimator를 어떻게 사용할 수 있을까?

## Description

- 애니메이션의 타이밍과 이동을 제어하기 위해 사용한다.
- SwiftUI에서는 [[PhaseAnimator]]와 [[KeyframeAnimator]]를 사용해 제어할 수 있다.
	- `KeyframeAnimator`는 더 복잡한 애니메이션을 구현할 때 사용한다.

### `.phaseAnimator`와 `PhaseAnimator {}`의 차이

- `.phaseAnimator`는 하나의 뷰에 모디파이어로 사용하여 개별적으로 애니메이션을 적용한다.
	- 기존의 `.animation`과 비슷하게 사용
- `PhaseAnimator`는 같은 애니메이션의 순서를 적용할 때 여러 뷰에 애니메이션을 적용한다.

## 주요 기능

- 트리거를 설정하지 않을 경우 기본적으로 계속 반복한다.
- `phase`에 따라서 어떤 애니메이션을 적용할 지 정할 수 있다.
- `enum AnimationPhase: CaseIterable { ... }` 형식의 열거형을 만들어서 애니메이션을 적용할 수 있다.

## 코드 예시

```Swift
import SwiftUI

enum LemonAnimationPhase: CaseIterable {
    case initial
    case moveUp
    case moveDown

    var offset: Double {
        switch self {
        case .initial:
            0
        case .moveUp:
            -10
        case .moveDown:
            10
        }
    }

    var scale: Double {
        switch self {
        case .initial:
            1
        case .moveUp:
            1.5
        case .moveDown:
            0.5
        }
    }
}

struct LemonPhaseAnimatorView: View {
    @State private var trigger: Bool = false

    var body: some View {
        VStack {
            Text("기본적으로 반복 재생")
                .font(.headline)

            Text("❤️")
                .font(.largeTitle)
                .phaseAnimator([false, true]) { content, phase in
                    content
                        .rotationEffect(.degrees(phase ? -15 : 15))
                } animation: { _ in
                    .bouncy
                }
        }
        .padding()
        .background(
            .background.secondary,
            in: RoundedRectangle(cornerRadius: 16)
        )

        VStack {
            Text("트리거를 사용하여 재생")
                .font(.headline)

            Text("❤️")
                .font(.largeTitle)
                .phaseAnimator([false, true], trigger: trigger) {
                    content,
                    phase in
                    content
                        .rotationEffect(.degrees(phase ? -15 : 15))
                } animation: { _ in
                    .bouncy
                }
            Button("트리거") {
                trigger.toggle()
            }
        }
        .padding()
        .background(
            .background.secondary,
            in: RoundedRectangle(cornerRadius: 16)
        )

        VStack {
            Text("커스텀 애니메이션 페이즈")
                .font(.headline)

            Text("❤️")
                .font(.largeTitle)
                .phaseAnimator(LemonAnimationPhase.allCases) { content, phase in
                    content
                        .offset(y: phase.offset)
                        .scaleEffect(phase.scale)
                }
        }
        .padding()
        .background(
            .background.secondary,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}

#Preview {
    LemonPhaseAnimatorView()
}
```

## Keywords

- [[KeyframeAnimator]]

## References

- [Controlling the timing and movements of your animations | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/controlling-the-timing-and-movements-of-your-animations)