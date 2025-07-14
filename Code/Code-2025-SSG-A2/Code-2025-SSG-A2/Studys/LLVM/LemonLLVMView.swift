//
//  LemonLLVMView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 7/13/25.
//

import SwiftUI

struct LemonLLVMView: View {
  @State private var viewModel: LemonLLVMViewModel = .init()

  var body: some View {
    VStack {
      VStack {
        Text("\(viewModel.count)")

        Button("Increase") {
          viewModel.increase()
        }
        
        Button("Decrease") {
          viewModel.decrease()
        }
      }
      .padding()
      .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

      VStack {
        ForEach(viewModel.names, id: \.self) { name in
          Text(name)
        }
      }
      .padding()
      .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
  }
}

@Observable
final class LemonLLVMViewModel {
  var count: Int
  var increasing: Int
  
  init() {
    self.count = 0
    // Watchpoint 설정
    // wa s v _count
    self.increasing = 1
  }

  func increase() {
    // names 수정
    // po names
    // p names[1] = "Mango"
    count += increasing
  }
  
  func decrease() {
    count -= increasing
  }

  var names: [String] = ["Lemon", "Orange", "Apple"]
}

#Preview {
  LemonLLVMView()
}
