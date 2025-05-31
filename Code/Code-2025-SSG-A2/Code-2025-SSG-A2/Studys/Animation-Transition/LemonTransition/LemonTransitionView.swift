//
//  LemonTransitionView.swift
//  Code-2025-SSG-A2
//
//  Created by 정희균 on 5/31/25.
//

import SwiftUI

enum LemonTransitionType: String, CaseIterable, Identifiable {
    case opacity = "opacity"
    case slide = "slide"
    case moveLeading = "move(edge: .leading)"
    case moveTrailing = "move(edge: .trailing)"
    case scale = "scale"
    case asymmetric = "asymmetric(insertion: .scale, removal: .opacity)"

    var id: String { rawValue }

    var transition: AnyTransition {
        switch self {
        case .opacity:
            return .opacity
        case .slide:
            return .slide
        case .moveLeading:
            return .move(edge: .leading)
        case .moveTrailing:
            return .move(edge: .trailing)
        case .scale:
            return .scale
        case .asymmetric:
            return .asymmetric(insertion: .scale, removal: .opacity)
        }
    }
}

struct LemonTransitionView: View {
    @State private var isShowing = true

    var body: some View {
        ScrollView {
            ForEach(LemonTransitionType.allCases) { type in
                LemonTextTransitionView(
                    name: type.rawValue,
                    transition: type.transition
                )
                .padding()
            }
        }
        .padding()
    }
}

struct LemonTextTransitionView: View {
    var name: String = ""
    var transition = AnyTransition.opacity

    @State private var isShowing = true
    var body: some View {
        VStack {
            Text("\(name)")
                .font(.headline)
                .padding()
            if isShowing {
                HStack {
                    Text("Hello")
                        .font(.largeTitle)
                        .bold()
                }
                .padding()
                .transition(transition)
            }
            Button("Show") {
                withAnimation(.easeInOut) {
                    isShowing.toggle()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            .background.secondary,
            in: RoundedRectangle(cornerRadius: 16)
        )
    }
}

#Preview {
    LemonTransitionView()
}
