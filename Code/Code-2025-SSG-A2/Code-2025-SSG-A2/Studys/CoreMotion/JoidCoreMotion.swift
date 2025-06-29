//
//  JoidCoreMotion.swift
//  Code-2025-SSG-A2
//
//  Created by 나현흠 on 6/29/25.
//

import SwiftUI
import CoreMotion

struct JoidCoreMotion: View {
    @State private var rotationRate: CMRotationRate = .init()
    @State private var offset: CGSize = .zero
    @State private var isStarted: Bool = false
    @State private var shakeCount = 0
    @State private var isShaking = false
    private let motionManager = CMMotionManager()

    var body: some View {
        VStack {
            Color.blue.opacity(0.1).ignoresSafeArea()
            Text("Shake Count: \(shakeCount)")
                .font(.largeTitle)
                .padding()
            VStack{
                Button(isShaking ? "멈추기" : "측정 시작") {
                    if isShaking {
                        motionManager.stopAccelerometerUpdates()
                    } else{
                        startDetectingShakes()
                    }
                    isShaking.toggle()
                }
                Button("횟수 초기화"){
                    shakeCount = 0
                }
            }
        }
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()
            VStack {
                Text("Gyroscope")
                    .font(.title)
                
                Text("x: \(rotationRate.x, specifier: "%.2f")")
                Text("y: \(rotationRate.y, specifier: "%.2f")")
                Text("z: \(rotationRate.z, specifier: "%.2f")")
            }
            
            VStack{
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 60, height: 60)
                    .offset(offset)
                    .animation(.easeOut(duration: 0.1), value: offset)
                
                VStack {
                    Spacer()
                    Button(isStarted ? "모션 중지" : "모션 시작") {
                        if isStarted {
                            motionManager.stopDeviceMotionUpdates()
                            motionManager.stopGyroUpdates()
                        } else{
                            startMotionUpdates()
                            startGyroUpdates()
                        }
                        isStarted.toggle()
                    }
                    .padding()
                }
            }
            .padding(.top, 40)
        }
    }

    private func startDetectingShakes() {
        guard motionManager.isAccelerometerAvailable else { return }

        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let acceleration = data?.acceleration else { return }

            let threshold = 2.0
            let magnitude = sqrt(acceleration.x * acceleration.x +
                                 acceleration.y * acceleration.y +
                                 acceleration.z * acceleration.z)

            if magnitude > threshold {
                shakeCount += 1
            }
        }
    }
    
    func startMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else { return }

        motionManager.deviceMotionUpdateInterval = 0.02
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let gravity = motion?.gravity else { return }

            let x = gravity.x * 100
            let y = -gravity.y * 100
            offset = CGSize(width: x, height: y)
        }
    }
    private func startGyroUpdates() {
            guard motionManager.isGyroAvailable else { return }
    
            motionManager.gyroUpdateInterval = 0.2
            motionManager.startGyroUpdates(to: .main) { data, error in
                guard let gyroData = data else { return }
                rotationRate = gyroData.rotationRate
            }
        }
}

#Preview {
    VStack {
        JoidCoreMotion()
    }
}
