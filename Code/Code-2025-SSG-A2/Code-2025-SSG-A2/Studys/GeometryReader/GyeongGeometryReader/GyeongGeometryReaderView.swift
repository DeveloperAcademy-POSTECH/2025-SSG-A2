//
//  GyeongGeometryReaderView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/29/25.
//

import SwiftUI

struct GyeongGeometryReaderView: View {
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .frame(width: geometry.size.width / 2, height: geometry.size.width / 2)
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height / 2)
        }
    }
}

#Preview {
    GyeongGeometryReaderView()
}
