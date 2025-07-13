import SwiftUI

struct TutorialMultiView: View {
    @Binding var currentView: TutorialType
    
    var body: some View {
        Text("Tutorial Multi View")
            .font(.extraLargeTitle)
            .padding()
    }
}

#Preview(windowStyle: .automatic) {
    TutorialMultiView(currentView: .constant(.tut1))
}   