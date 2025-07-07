// https://developer.apple.com/tutorials/develop-in-swift/add-depth-to-your-app

import SwiftUI

struct Tut1View: View {
    @State private var colors: [Color] = [.cyan, .blue]
    @State private var depth = 0.0

    var body: some View {
        VStack(spacing: 40) {
            Text("Tunnel of Circles")
                .font(.largeTitle)
                .padding()
            
            CircleView(colors: colors, depth: depth)
                .padding(.bottom, 30)
            
            RemoteView(colors: $colors, depth: $depth)
        }
        .frame(minHeight: 560)
    }
}

#Preview(windowStyle: .automatic) {
    Tut1View()
}