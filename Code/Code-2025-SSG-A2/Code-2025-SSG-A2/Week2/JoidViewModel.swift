//
//  JoidViewModel.swift
//  Code-2025-SSG-A2
//
//  Created by 나현흠 on 5/24/25.
//

import SwiftUI

// Model
struct Counter {
    var value: Int
}

// ViewModel
class JoidCounterViewModel: ObservableObject {
    @Published private(set) var counter = Counter(value: 0)

    func increment() {
        counter.value += 1
    }

    func reset() {
        counter = Counter(value: 0)
    }
}

// View
struct JoidCounterView: View {
    @StateObject private var vm = JoidCounterViewModel()

    var body: some View {
        VStack{
            Text("현재 값: \(vm.counter.value)")
                .font(.largeTitle)

            Button("1 증가") {
                vm.increment()
            }

            Button("리셋") {
                vm.reset()
            }
        }
        .padding()
    }
}

#Preview {
    JoidCounterView()
}
