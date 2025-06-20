//
//  MiruCountView.swift
//  Code-2025-SSG-A2
//
//  Created by Miru on 2025/5/26.
//

import SwiftUI

extension MiruMVVMCountView {
    final class ViewModel: ObservableObject {
        @Published var count: Int = 0
        
        func increase() { count += 1 }
    }
}

struct MiruMVVMCountView: View {
    @Binding var parentCount: Int
    @ObservedObject var viewModel = ViewModel()
//    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("CountView's Count is \(viewModel.count)")
            
            Button(action: {
                viewModel.increase()
            }, label: {
                
                Text("Add Count")
            })
            
            Text("ParentView's Count is \(parentCount)")
            
            Button(action: {
                parentCount += 1
            }, label: {
                
                Text("Add Count")
            })
        }
    }
}

struct MiruMVVMParentView: View {
    @State private var count: Int = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("ParentView's count is \(count)")
                NavigationLink {
                    MiruMVVMCountView(parentCount: $count)
                } label: {
                    Text("Navigate to CountView")
                }
            }
        }
    }
}

#Preview {
    MiruMVVMParentView()
}
