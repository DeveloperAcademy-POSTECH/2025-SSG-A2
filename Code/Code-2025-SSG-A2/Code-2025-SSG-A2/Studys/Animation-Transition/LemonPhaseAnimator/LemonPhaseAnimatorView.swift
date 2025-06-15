//
//  LemonPhaseAnimatorView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 6/15/25.
//

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
        ScrollView {
            Text(".phaseAnimator")
                .font(.title)
                .fontDesign(.monospaced)
            phaseAnimatorDefault
            phaseAnimatorTrigger
            phaseAnimatorCustomPhase

            Text("PhaseAnimator")
                .font(.title)
                .fontDesign(.monospaced)
            phaseAnimatorClosure
        }
    }

    private var phaseAnimatorDefault: some View {
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
    }

    private var phaseAnimatorTrigger: some View {
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
    }

    private var phaseAnimatorCustomPhase: some View {
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

    private var phaseAnimatorClosure: some View {
        VStack {
            PhaseAnimator(LemonAnimationPhase.allCases) { phase in
                Text("기본적으로 반복 재생")
                    .font(.headline)
                    .scaleEffect(phase.scale)

                Text("❤️")
                    .font(.largeTitle)
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
