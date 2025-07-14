//
//  GyeongUserDefaultsView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 7/13/25.
//

import SwiftUI

struct GyeongUserDefaultsView: View {
    @State private var isFirstLaunch = false
    
    var body: some View {
        VStack(spacing: 20) {
            if isFirstLaunch {
                Text("🎉 앱을 처음 실행하셨네요! 환영합니다.")
                    .font(.largeTitle)
            } else {
                Text("다시 오셨군요! 👋")
                    .font(.largeTitle)
            }
            
            Button("Reset하기") {
                UserDefaults.standard.removeObject(forKey: "hasLaunchBefore")
                checkFirstLaunch()
            }
        }
        .onAppear {
            checkFirstLaunch()
        }
    }
    
    private func checkFirstLaunch() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "hasLaunchBefore") == false {
            isFirstLaunch = true
            defaults.set(true, forKey: "hasLaunchBefore")
        } else {
            isFirstLaunch = false
        }
    }
}

#Preview {
    GyeongUserDefaultsView()
}
