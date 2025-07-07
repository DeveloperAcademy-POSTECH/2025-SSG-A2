// https://developer.apple.com/tutorials/develop-in-swift/present-common-controls-in-an-ornament

import SwiftUI
import RealityKit
import RealityKitContent

struct Tut2View: View {
    @Environment(\.openWindow) private var openWindow
    @State private var label = Label()

    var body: some View {
        LabelView(label: $label)
            .padding(55)
            .ornament(attachmentAnchor: .scene(.bottom)) {
                HStack(spacing: 30) {
                    Slider(value: $label.cornerRadius, in: 0...100)
                        .frame(width: 100)
                    HStack(spacing: 10) {
                        ForEach(Label.colors.indices, id: \.self) { index in
                            ColorButton(color: Label.colors[index]) {
                                label.colorIndex = index
                            }
                        }
                    }
                    Button("Create") {
                        openWindow(value: label)
                        label = Label(cornerRadius: label.cornerRadius, colorIndex: label.colorIndex)
                    }
                }
                .padding([.top, .bottom], 15)
                .padding([.leading, .trailing], 38)
                .glassBackgroundEffect()
            }
    }
}


#Preview(windowStyle: .automatic) {
    Tut2View()
}
