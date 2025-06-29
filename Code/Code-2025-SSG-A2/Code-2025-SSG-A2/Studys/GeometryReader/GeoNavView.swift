//
//  GeoNavView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/29/25.
//

import SwiftUI

struct GeoNavView: View {
    var body: some View {
        NavigationStack{
            List{
                Text("Gyeong")
                NavigationLink("GyeongGeometryReaderView", destination: GyeongGeometryReaderView())
                NavigationLink("GyeongGeometryProxyView", destination: GyeongGeometryProxyView())
                NavigationLink("GyeongAlignmentView", destination: GyeongAlignmentView())
            }
            .navigationTitle("GeometryReader")
        }
    }
}

#Preview {
    GeoNavView()
}
