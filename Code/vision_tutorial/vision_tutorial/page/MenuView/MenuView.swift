import SwiftUI

struct MenuView: View {
    @Binding var currentView: TutorialType
    
    var body: some View {
        HStack(spacing: 30) {
            TutorialWindowView(currentView: $currentView)
            // TutorialMultiView(currentView: $currentView)
        }
        .frame(minWidth: 400, minHeight: 300)
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
