//
//  SubscriptNavView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/1/25.
//

import SwiftUI

struct SubscriptNavView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink("GyeongSubscriptView", destination: GyeongSubscriptView())
            }
            .navigationTitle("Subscript")
        }
    }
}
