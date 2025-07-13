import SwiftUI

struct TutorialWindowButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
    }
}

struct TutorialWindowView: View {
    @Binding var currentView: TutorialType

    var body: some View {
        VStack(spacing: 10) {
            Text("Vision Tutorial")
                .font(.extraLargeTitle)
                .padding()
            VStack(spacing: 20) {
                TutorialWindowButtonView(title: "Tutorial 1 - Circle Animation", action: {
                    currentView = .tut1
                })

                TutorialWindowButtonView(title: "Tutorial 2 - Label Maker", action: {
                    currentView = .tut2
                })
                
                TutorialWindowButtonView(title: "Tutorial 3 - 3D Object", action: {
                    currentView = .tut3
                })
            }
            .frame(minWidth: 400, minHeight: 300)
            .padding()
        }
    }
}

#Preview(windowStyle: .automatic) {
    TutorialWindowView(currentView: .constant(.tut1))
}
