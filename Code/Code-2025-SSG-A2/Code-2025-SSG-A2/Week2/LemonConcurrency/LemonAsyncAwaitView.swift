//
//  LemonAsyncAwaitView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 5/23/25.
//

import SwiftUI

struct LemonAsyncAwaitView: View {
    @State private var number = 0

    var body: some View {
        VStack {
            Text("\(number)")

            Button("Generate Number") {
                Task {
                    // 랜덤 숫자 생성 함수를 기다림
                    number = try await generateNumber()
                }
            }
        }
    }

    // 비동기 함수임을 명시
    private func generateNumber() async throws -> Int {
        try await Task.sleep(for: .seconds(1))
        return Int.random(in: 1...100)
    }
}

#Preview {
    LemonAsyncAwaitView()
}
