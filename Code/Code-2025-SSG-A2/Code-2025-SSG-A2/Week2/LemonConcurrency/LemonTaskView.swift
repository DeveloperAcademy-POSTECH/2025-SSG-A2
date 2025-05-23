//
//  LemonTaskView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 5/23/25.
//

import SwiftUI

struct LemonTaskView: View {
    @State private var generateNumberTask: Task<Int, Error>?
    @State private var number = 0

    var body: some View {
        VStack {
            Text("\(number)")
            Button("Generate Number") {
                // 랜덤 숫자 생성 작업을 생성
                generateNumberTask =
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        return Int.random(in: 1...100)
                    }

                // 생성된 작업으로부터 결과를 기다리는 작업을 생성
                Task {
                    do {
                        number = try await generateNumberTask?.value ?? 0
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    LemonTaskView()
}
