import SwiftUI

// NavigationView 예시
struct NavigationViewExample: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("숫자 선택하기", destination: NumberSelectionView())
            }
            .navigationTitle("NavigationView")
        }
    }
}

// NavigationStack 예시
struct NavigationStackExample: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                NavigationLink("숫자 선택하기", destination: NumberSelectionView())
                Button("이전 경로 보기") {
                    print("현재 경로: \(navigationPath)")
                }
            }
            .navigationTitle("NavigationStack")
            .navigationDestination(for: Int.self) { number in
                NumberDetailView(number: number)
            }
        }
    }
}

struct NumberSelectionView: View {
    var body: some View {
        List {
            ForEach(1...5, id: \.self) { number in
                NavigationLink("숫자 \(number)", value: number)
            }
        }
        .navigationTitle("숫자 선택")
    }
}

struct NumberDetailView: View {
    let number: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("선택한 숫자: \(number)")
                .font(.title)
            
            Button("이전 화면으로") {
                dismiss()
            }
            .padding()
        }
        .navigationTitle("숫자 \(number)")
    }
}

// 메인 뷰
struct NavigationExampleView: View {
    var body: some View {
        TabView {
            NavigationViewExample()
                .tabItem {
                    Label("NavigationView", systemImage: "1.circle")
                }
            
            NavigationStackExample()
                .tabItem {
                    Label("NavigationStack", systemImage: "2.circle")
                }
        }
    }
}

#Preview {
    NavigationExampleView()
} 