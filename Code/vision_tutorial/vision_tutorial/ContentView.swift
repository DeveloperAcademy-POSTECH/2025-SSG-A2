import SwiftUI

enum TutorialType {
    case menu
    case tut1
    case tut2
    case tut3
}

struct BacktoMenuButtonView: View {
    @Binding var currentView: TutorialType
    var body: some View {
        HStack {
            Button("← 메뉴") {
                currentView = .menu
            }
            .padding()
            Spacer()
        }
    }
}

struct ContentView: View {
    @State private var currentView: TutorialType = .menu
    
    var body: some View {
        switch currentView {
        case .menu:
            MenuView(currentView: $currentView)
        case .tut1:
            VStack(spacing: 0) {
                BacktoMenuButtonView(currentView: $currentView)
                Tut1View()
            }
        case .tut2:
            VStack(spacing: 0) {
                BacktoMenuButtonView(currentView: $currentView)
                Tut2View()
            }
        case .tut3:
            VStack(spacing: 0) {
                BacktoMenuButtonView(currentView: $currentView)
                Tut3View()
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
