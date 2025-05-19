//
//  Week1AnnotationView.swift
//  Code-2025-SSG-A2
//
//  Created by 나현흠 on 5/15/25.
//

import SwiftUI

//MARK: 여기부터 @State & Binding

struct Week1AnnotationView: View {
    @State var count = 0

    var body: some View {
        VStack(spacing:0) {
            ZStack {
                Color(.yellow)
                VStack {
                    Text("바인딩뷰랑 원래뷰 둘다 바뀜: \(count)")
                    Button("덧셈") {
                        count += 1
                    }
                }
            }
            

            Week1ChildrenView(count: $count)
                
        }
    }
}

struct Week1ChildrenView: View {
    @Binding var count: Int

    var body: some View {
        ZStack {
            Color(.green)
            VStack {
                Text("여기는 children 뷰\n여기서 버튼 조작해도 값 바뀜")
                Button("childrenview 버튼") {
                    count += 1
                }
            }
        }
    }
}

//MARK: 여기부터 @ObservedObject

class Week1CounterViewModel: ObservableObject {
    @Published var count = 0
}

struct Week1CounterView: View {
    @ObservedObject var viewModel: Week1CounterViewModel

    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
            Button("Up") {
                viewModel.count += 1
            }
        }
    }
}

//MARK: 여기부터 @StateObject

class Week1MyViewModel: ObservableObject {
    @Published var count = 0
}

struct Week1MainView: View {
    var body: some View {
        TabView {
            Week1ScreenA()
                .tabItem {
                    Label("A", systemImage: "1.circle")
                }

            Week1ScreenB()
                .tabItem {
                    Label("B", systemImage: "2.circle")
                }
        }
    }
}

struct Week1ScreenA: View {
    @StateObject private var vm = Week1MyViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Screen A Count: \(vm.count)")
            Button("Increment") {
                vm.count += 1
            }
        }
        .padding()
    }
}

struct Week1ScreenB: View {
    @StateObject private var vm = Week1MyViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Screen B Count: \(vm.count)")
            Button("Decrement") {
                vm.count -= 1
            }
        }
        .padding()
    }
}

#Preview {
    Week1AnnotationView() //State & Binding 예제
//    Week1CounterView(viewModel: Week1CounterViewModel()) // ObservedObject 예제
//    Week1MainView() // StateObject 예제
}
