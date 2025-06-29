//
//  GyeongAlignmentView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/29/25.
//

import SwiftUI

struct GyeongAlignmentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                Text("Hello, World!")
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                
                Spacer()
                
                Text("This is SwiftUI Geometry")
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
            }
        }
    }
}

#Preview {
    GyeongAlignmentView()
}
