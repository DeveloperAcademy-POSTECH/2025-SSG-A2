>[!question]
>GQ1. KeyframeAnimator는 무엇일까?
>GQ2. KeyframeAnimator를 어떻게 사용할 수 있을까?

## Description

- [[PhaseAnimator]]보다 더 정교한 애니메이션의 타이밍과 이동을 제어하기 위해 사용한다.
- KeyframeAnimator는 Animatable 프로토콜을 따르는 어떤 값이든 애니메이션을 적용할 수 있다.

### 사용 방법

1. `keyframeAnimator(initialValue:repeating:content:keyframes:)`
	한 번 혹은 계속 반복하도록 애니메이션을 설정할 때 사용한다.
2. `keyframeAnimator(initialValue:trigger:content:keyframes:)`
	트리거에 따라 애니메이션이 적용되도록 애니메이션을 설정할 때 사용한다.

## 주요 기능

### `initialValue`

애니메이션을 독립적으로 적용하기 위한 값을 담은 구조체를 만들어서 전달한다.

```Swift
struct AnimationValues {
    var x: CGFloat
    var y: CGFloat
    var scale: CGFloat
}
```

### `content` 클로저

```Swift
{ content, value in
    content
        .offset(x: value.x, y: value.y)
        .scaleEffect(value.scale)
}
```

- `content`: 애니메이션을 적용할 뷰
- `value`: 현재 보간된 값

> SwiftUI는 `content` 클로저를 애니메이션의 각 프레임마다 호출하기 때문에 복잡한 계산을 넣는 것을 피해야 한다.

### `keyframes` 클로저

```Swift
keyframes: { track in
    KeyframeTrack(\.x) {
        CubicKeyframe(-100, duration: 1)
        CubicKeyframe(100, duration: 1)
    }
    KeyframeTrack(\.y) {
        LinearKeyframe(-300, duration: 2)
    }
    KeyframeTrack(\.scale) {
        CubicKeyframe(0.0, duration: 0.5)
        CubicKeyframe(1.0, duration: 1.0)
        CubicKeyframe(0.0, duration: 0.5)
    }
}
```

- `KeyframeTrack`
	- 프로퍼티(`key path`)에 대해 시간에 따른 값을 정의하는 트랙
- 키프레임 종류
	- `CubicKeyframe`: 부드러운 커브로 보간
    - `LinearKeyframe`: 일정 속도로 보간
    - `SpringKeyframe`: 스프링 물리 기반 보간

## 코드 예시

```Swift
struct LemonKeyframeAnimatorAnimationValues {
    var x: CGFloat = 0.0
    var y: CGFloat = 0.0
    var scale: CGFloat = 0.0
}

struct LemonKeyframeAnimatorView: View {
    @State private var text: String = "안녕하세요"
    @State private var trigger: Bool = false

    private static let bubbleCounts: Int = 10

    @State private var bubbleTriggers: [Bool] = Array(
        repeating: false,
        count: bubbleCounts
    )
    @State private var bubbleOffsets: [CGSize] = Array(
        repeating: .zero,
        count: bubbleCounts
    )
    @State private var bubbleScales: [CGFloat] = Array(
        repeating: .zero,
        count: bubbleCounts
    )

    var body: some View {
        ZStack {
            ForEach(0..<LemonKeyframeAnimatorView.bubbleCounts, id: \.self) {
                index in
                BubbleText(text)
                    .keyframeAnimator(
                        initialValue: LemonKeyframeAnimatorAnimationValues(),
                        trigger: bubbleTriggers[index]
                    ) { content, value in
                        content
                            .scaleEffect(value.scale)
                            .offset(x: value.x, y: value.y)
                    } keyframes: { _ in
                        KeyframeTrack(\.x) {
                            CubicKeyframe(-100, duration: 1)
                            CubicKeyframe(100, duration: 1)
                        }
                        KeyframeTrack(\.y) {
                            LinearKeyframe(-300, duration: 2)
                        }
                        KeyframeTrack(\.scale) {
                            CubicKeyframe(0.0, duration: 0.5)
                            CubicKeyframe(1.0, duration: 1.0)
                            CubicKeyframe(0.0, duration: 0.5)
                        }
                    }
                    .offset(bubbleOffsets[index])
                    .scaleEffect(bubbleScales[index])
            }

            HStack {
                TextField("텍스트를 입력하세요.", text: $text)

                Button {
                    for index in 0..<LemonKeyframeAnimatorView.bubbleCounts {
                        bubbleOffsets[index] = CGSize(
                            width: .random(in: -100..<100),
                            height: .random(in: 0..<300)
                        )
                        bubbleScales[index] = CGFloat.random(in: 0.8..<1.5)
                        DispatchQueue.main.asyncAfter(
                            deadline: .now() + Double(index) * 0.1
                        ) {
                            bubbleTriggers[index].toggle()
                        }
                    }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28)
                        .tint(.green)
                }
                .disabled(text.isEmpty)
            }
            .padding()
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 16)
            )
            .padding()
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }

    private func BubbleText(_ text: String) -> some View {
        Text(text)
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.green, in: RoundedRectangle(cornerRadius: 32))
    }
}
```

## Keywords

- [[Animatable]]
- [[KeyPath]]

## References

- [Controlling the timing and movements of your animations | Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/controlling-the-timing-and-movements-of-your-animations)