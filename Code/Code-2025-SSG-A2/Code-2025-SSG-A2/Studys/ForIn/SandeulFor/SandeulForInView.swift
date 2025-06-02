//
//  SandeulFor.swift
//  Code-2025-SSG-A2
//
//  Created by 산들 on 6/1/25.
//

import SwiftUI

struct SandeulForInView: View {
    let numbers = [1, 2, 3, 4, 5, 6]

    var body: some View {
        VStack {
            ForEach(numbers.filter { $0 % 2 == 0 }, id: \.self) { number in
                Text("짝수: \(number)")
            }
            Button {
                for number in numbers where number % 2 == 0 {
                    print("짝수는 \(number)")
                }
            } label: {
                Text("click")
            }
        }
        .padding()
    }
}

#Preview {
    SandeulForInView()
}

