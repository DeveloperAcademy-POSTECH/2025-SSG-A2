import SwiftUI

struct RemoteView: View {
    @Binding var colors: [Color]
    @Binding var depth: Double
    
    var body: some View {
        Grid {
            GridRow {
                Text("Depth")
                Slider(value: $depth, in: -50...50) {
                    Text("Depth")
                }
            }
            GridRow {
                Text("Colors")
                HStack {
                    ColorPicker("Color", selection: $colors[0])
                    ColorPicker("Color", selection: $colors[1])
                    Spacer()
                }
                .labelsHidden()
            }
        }
        .padding(30)
        .background(.thickMaterial)
    }
}

#Preview {
    @Previewable @State var colors: [Color] = [.cyan, .blue]
    @Previewable @State var depth = 0.0
    
    RemoteView(colors: $colors, depth: $depth)
        .padding()
}