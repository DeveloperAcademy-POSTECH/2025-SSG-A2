//
//  JoidmaskModifier.swift
//  Code-2025-SSG-A2
//
//  Created by 나현흠 on 6/19/25.
//

import SwiftUI

struct JoidmaskModifier: View {
    @State private var fillProgress: CGFloat = 0.0
    @State private var rectProgress: CGFloat = 0.0

    var body: some View {
        VStack {
            ZStack {
                Text("JOID")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.black)

                Text("JOID")
                    .font(.system(size: 64, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                    )
                    .mask(
                        GeometryReader { geo in
                            Rectangle()
                                .frame(width: geo.size.width * fillProgress, height: geo.size.height)
                                .alignmentGuide(.leading) { _ in 0 }
                        }
                    )
            }

            Rectangle()
                .fill(LinearGradient(colors: [.green, .yellow], startPoint: .leading, endPoint: .trailing))
                .frame(width: 300 * rectProgress, height: 30)
                .frame(width: 300, alignment: .leading)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(5)
                .padding(.top, 20)

            Button("텍스트 채우기") {
                withAnimation(.linear(duration: 1)) {
                    fillProgress = 1.0
                }
            }
            .padding(.top, 20)

            Button("사각형 채우기") {
                withAnimation(.linear(duration: 1)) {
                    rectProgress = 1.0
                }
            }
            .padding(.top, 10)
            
            Button("원래 상태로 돌리기") {
                fillProgress = 0.0
                rectProgress = 0.0
            }
            .padding(.top, 10)
            
        }
    }
}

#Preview {
    JoidmaskModifier()
}
