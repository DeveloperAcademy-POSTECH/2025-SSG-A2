//
//  GyeongAppStorageView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 7/6/25.
//

import SwiftUI

struct GyeongAppStorageView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    
    var body: some View {
        if isLoggedIn {
            LoggedInView()
        } else {
            LoginView()
        }
    }
}

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack {
            Text("로그인 화면")
            Button("로그인") {
                // 로그인 처리 로직
                isLoggedIn = true
            }
        }
    }
}

struct LoggedInView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        VStack {
            Text("환영합니다!")
            Button("로그아웃") {
                isLoggedIn = false
            }
        }
    }
}

#Preview {
    GyeongAppStorageView()
}
