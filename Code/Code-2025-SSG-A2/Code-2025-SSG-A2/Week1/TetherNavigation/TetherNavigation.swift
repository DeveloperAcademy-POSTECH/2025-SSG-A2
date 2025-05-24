import SwiftUI

// 메인 뷰
struct NavigationExampleView: View {
    var body: some View {
        
        VStack {
            TetherNavigationView()
            TetherNavigationStack()
        }
    }
}

#Preview {
    NavigationExampleView()
}

