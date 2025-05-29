import SwiftUI

struct NavigationComparisonView: View {
    @State private var navigationPath = NavigationPath()
    @State private var selectedNumber = 1
    @State private var isNavigating = false
    
    var body: some View {
        VStack(spacing: 0) {
            // 공통 버튼
            Button("두 화면 모두 이동") {
                isNavigating = true
            }
            .padding()
            
            VStack {
                NavigationView {
                    VStack {
                        Text("현재 숫자: \(selectedNumber)")
                            .padding()
                        
                        Button("숫자 증가") {
                            selectedNumber += 1
                        }
                        .padding()
                        
                        if isNavigating {
                            NavigationLink("다음 화면으로", destination: DetailView(number: selectedNumber))
                        }
                    }
                    .navigationTitle("NavigationView")
                }
            }
            .frame(maxWidth: .infinity)
            
            Divider()
            
            VStack {
                NavigationStack(path: $navigationPath) {
                    VStack {
                        Text("현재 숫자: \(selectedNumber)")
                            .padding()
                        
                        Button("숫자 증가") {
                            selectedNumber += 1
                        }
                        .padding()
                        
                        if isNavigating {
                            NavigationLink("다음 화면으로", value: selectedNumber)
                        }
                    }
                    .navigationTitle("NavigationStack")
                    .navigationDestination(for: Int.self) { number in
                        DetailView(number: number)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct DetailView: View {
    let number: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("선택된 숫자: \(number)")
                .font(.title)
                .padding()
            
            Button("이전 화면으로") {
                dismiss()
            }
            .padding()
        }
        .navigationTitle("상세 화면")
    }
} 

#Preview{
    NavigationComparisonView()
}