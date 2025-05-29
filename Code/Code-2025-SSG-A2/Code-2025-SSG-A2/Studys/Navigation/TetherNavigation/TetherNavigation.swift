import SwiftUI

// 메인 뷰
struct TetherNavigationCompareView: View {
    var body: some View {
        VStack {
            TetherNavigationView()
            TetherNavigationStack()
        }
    }
}

#Preview {
    TetherNavigationCompareView()
}

