import SwiftUI

struct TetherNavigationView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack {
            NavigationView {
                VStack(spacing: 20) {
                    Text("현재 화면: 메인")
                        .font(.title2)
                    
                    NavigationLink("1번 화면으로 이동", destination: FirstScreenView())
                    
                    Text("⚠️ NavigationView는 여러 단계 뒤로가기 불가능")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
                .navigationTitle("NavigationView")
            }
        }
    }
}

struct FirstScreenView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("현재 화면: 1번")
                .font(.title2)
            
            NavigationLink("2번 화면으로 이동", destination: SecondScreenView())
        }
        .navigationTitle("1번 화면")
    }
}

struct SecondScreenView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("현재 화면: 2번")
                .font(.title2)
            
            NavigationLink("3번 화면으로 이동", destination: ThirdScreenView())
        }
        .navigationTitle("2번 화면")
    }
}

struct ThirdScreenView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("현재 화면: 3번")
                .font(.title2)
            
            Button("한 단계 뒤로 가기") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            
            Text("여러 단계 뒤로가기 불가능 ⚠️")
                .foregroundColor(.red)
                .padding()
        }
        .navigationTitle("3번 화면")
    }
}