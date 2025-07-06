//
//  GyeongGeometryProxyView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/29/25.
//

import SwiftUI

struct GyeongGeometryProxyView: View {
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .foregroundColor(.red)
                .frame(width: geometry.size.width / 2,
                       height: geometry.size.width / 2)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            
            Circle()
                .foregroundColor(.blue)
                .frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
                .position(x: geometry.safeAreaInsets.leading + geometry.size.width / 8,
                          y: geometry.safeAreaInsets.top  + geometry.size.width / 8)
        }
    }
}

#Preview {
    GyeongGeometryProxyView()
}
