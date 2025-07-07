//
//  GyeongAppStorageWithBindingView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 7/6/25.
//

import SwiftUI

struct GyeongAppStorageWithBindingView: View {
    @AppStorage("language") private var language = "Korean"
    
    var body: some View {
        VStack {
            Text("현재 언어: \(language)")
            LanguagePickerView(language: $language)  // 바인딩 전달
        }
        .padding()
    }
}

struct LanguagePickerView: View {
    @Binding var language: String

    var body: some View {
        Picker("언어 선택", selection: $language) {
            Text("한국어").tag("Korean")
            Text("영어").tag("English")
            Text("일본어").tag("Japanese")
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    GyeongAppStorageWithBindingView()
}
