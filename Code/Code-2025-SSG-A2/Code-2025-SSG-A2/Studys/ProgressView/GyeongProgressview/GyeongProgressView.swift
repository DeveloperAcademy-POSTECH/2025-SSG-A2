//
//  GyeongLinearProgressView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/23/25.
//

import SwiftUI

struct GyeongProgressView: View {
    @State private var progress = 0.5
    let workoutDateRange = Date()...Date().addingTimeInterval(5*60)
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
            Button("more") {
                progress += 0.05
            }
        }
        .padding()
        
        ProgressView()
        
        ProgressView(timerInterval: workoutDateRange) {
            Text("Workout")
        }
        .padding()
        
        VStack {
            ProgressView(value: 0.25) {
                Text("25% progress")
            }
            ProgressView(value: 0.75) {
                Text("75% progress")
            }
        }
        .progressViewStyle(PinkBorderedProgressViewStyle())
        .padding()
        
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(.circular)
        }
        .padding()
    }
}

struct PinkBorderedProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .padding(4)
            .border(.pink, width: 3)
            .cornerRadius(4)
    }
}

#Preview {
    GyeongProgressView()
}
