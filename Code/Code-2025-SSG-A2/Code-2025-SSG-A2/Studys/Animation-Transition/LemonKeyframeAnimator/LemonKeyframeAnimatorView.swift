//
//  LemonKeyframeAnimatorView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 6/22/25.
//

import SwiftUI

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

#Preview {
    LemonKeyframeAnimatorView()
}
