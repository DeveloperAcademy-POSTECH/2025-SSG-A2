//
//  LemonAnimationView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 5/31/25.
//

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
