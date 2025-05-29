//
//  LemonActorView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 5/23/25.
//

import SwiftUI

actor LemonActorCounter {
    var number = 0

    func increment() async {
        // 3초 대기
        try? await Task.sleep(for: .seconds(3))

        number += 1
    }

    func getNumber() -> Int {
        return number
    }
}

struct LemonActorView: View {
    private let counter = LemonActorCounter()

    @State private var number = 0

    var body: some View {
        VStack {
            // actor의 프로퍼티는 직접 접근할 수 없다.
            Text("Number: \(number)")

            Button("Increment") {
                Task {
                    await counter.increment()
                    // `actor`의 메서드는 `await`를 사용해야 한다.
                    number = await counter.getNumber()
                }
            }
        }
    }
}

#Preview {
    LemonActorView()
}
