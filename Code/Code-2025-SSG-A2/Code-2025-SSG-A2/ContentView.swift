//
//  ContentView.swift
//  Code-2025-SSG-A2
//
//  규칙
//  1. 외각 폴더명은 해당 주제
//  2. 주제 내부 폴더명은 닉네임+주제(파스칼케이스)

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink("Concurrency", destination: ConcurrencyNavView())
                NavigationLink("Enumeration", destination: EnumNavView())
                NavigationLink("Environment", destination: EnvironNavView())
                NavigationLink("MVVM", destination: MVVMNavView())
                NavigationLink("Navigation", destination: NavNavView())
            }
            .navigationTitle("SSG A2 study examples")
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
