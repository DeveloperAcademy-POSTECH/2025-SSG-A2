import SwiftUI

struct FirstView: View {
    var body: some View {
        VStack {
            Text("첫 번째 화면")
                .font(.title)
            Text("NavigationView와 NavigationStack의 차이점:")
                .padding()
            Text("1. NavigationStack은 iOS 16 이상에서 사용 가능")
            Text("2. NavigationStack은 더 유연한 네비게이션 제어 가능")
            Text("3. NavigationStack은 프로그래매틱 네비게이션 지원")
        }
        .navigationTitle("첫 번째 화면")
    }
}

struct SecondView: View {
    var body: some View {
        VStack {
            Text("두 번째 화면")
                .font(.title)
            Text("NavigationStack의 장점:")
                .padding()
            Text("1. 네비게이션 경로 관리 용이")
            Text("2. 딥링크 지원")
            Text("3. 네비게이션 상태 유지")
        }
        .navigationTitle("두 번째 화면")
    }
}