import SwiftUI

struct CircleView: View {
    let colors: [Color]
    let depth: Double
    
    private let minDiameter = 50.0
    private let diameterChange = 70.0
    
    var body: some View {
        ZStack {
            ForEach(0..<4) { index in
                Circle()
                    .stroke(lineWidth: 30)
                    .foregroundStyle(colors[index % 2])
                    .frame(height: minDiameter + diameterChange * Double(index))
                    .padding3D(.back, depth)
            }
        }
    }
}

#Preview {
    CircleView(colors: [.cyan, .blue], depth: 25.0)
        .padding()
}