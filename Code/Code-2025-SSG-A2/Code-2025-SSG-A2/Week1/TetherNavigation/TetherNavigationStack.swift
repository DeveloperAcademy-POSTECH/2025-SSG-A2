import SwiftUI

struct ScreenData: Hashable {
    var id: Int
    var text: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ScreenData, rhs: ScreenData) -> Bool {
        return lhs.id == rhs.id
    }
}

struct TetherNavigationStack: View {
    @State private var path = NavigationPath()
    @State private var screenDataMap: [Int: String] = [1: "", 2: "", 3: ""]
    
    var body: some View {
        VStack {
            NavigationStack(path: $path) {
                VStack(spacing: 20) {
                    Text("현재 화면: 메인")
                        .font(.title2)
                    
                    // 저장된 데이터 표시
                    VStack(alignment: .leading, spacing: 10) {
                        Text("저장된 데이터:")
                            .font(.headline)
                        
                        ForEach([1, 2, 3], id: \.self) { screenId in
                            if !screenDataMap[screenId, default: ""].isEmpty {
                                Text("화면 \(screenId): \(screenDataMap[screenId, default: ""])")
                                    .padding(.leading)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    NavigationLink("1번 화면으로 이동", value: ScreenData(id: 1, text: screenDataMap[1, default: ""]))
                    
                    Text("✅ NavigationStack은 화면 간 데이터 저장 가능")
                        .font(.caption)
                        .foregroundColor(.green)
                }
                .navigationTitle("NavigationStack")
                .navigationDestination(for: ScreenData.self) { screenData in
                    switch screenData.id {
                    case 1:
                        StackFirstScreenView(path: $path, 
                                            text: Binding(
                                                get: { screenDataMap[1, default: ""] },
                                                set: { screenDataMap[1] = $0 }
                                            ))
                    case 2:
                        StackSecondScreenView(path: $path, 
                                             text: Binding(
                                                 get: { screenDataMap[2, default: ""] },
                                                 set: { screenDataMap[2] = $0 }
                                             ))
                    case 3:
                        StackThirdScreenView(path: $path, 
                                            text: Binding(
                                                get: { screenDataMap[3, default: ""] },
                                                set: { screenDataMap[3] = $0 }
                                            ))
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct StackFirstScreenView: View {
    @Binding var path: NavigationPath
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("현재 화면: 1번")
                .font(.title2)
            
            TextField("텍스트를 입력하세요", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("저장") {
                // 저장 효과를 시각적으로 표현
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            .buttonStyle(.borderedProminent)
            
            NavigationLink("2번 화면으로 이동", value: ScreenData(id: 2, text: ""))
            
            Text("입력된 텍스트는 자동으로 저장됩니다")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("1번 화면")
    }
}

struct StackSecondScreenView: View {
    @Binding var path: NavigationPath
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("현재 화면: 2번")
                .font(.title2)
            
            TextField("텍스트를 입력하세요", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("저장") {
                // 저장 효과를 시각적으로 표현
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            .buttonStyle(.borderedProminent)
            
            NavigationLink("3번 화면으로 이동", value: ScreenData(id: 3, text: ""))
            
            Text("입력된 텍스트는 자동으로 저장됩니다")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .navigationTitle("2번 화면")
    }
}

struct StackThirdScreenView: View {
    @Binding var path: NavigationPath
    @Binding var text: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Text("현재 화면: 3번")
                .font(.title2)
            
            TextField("텍스트를 입력하세요", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("저장") {
                // 저장 효과를 시각적으로 표현
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            .buttonStyle(.borderedProminent)
            
            Button("한 단계 뒤로 가기") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            
            Button("두 단계 뒤로 가기") {
                if path.count >= 2 {
                    path.removeLast(2)
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("메인으로 바로 가기") {
                path = NavigationPath()
            }
            .buttonStyle(.borderedProminent)
            
            Text("모든 화면의 입력값이 저장됩니다 ✅")
                .foregroundColor(.green)
                .padding()
        }
        .padding()
        .navigationTitle("3번 화면")
    }
}