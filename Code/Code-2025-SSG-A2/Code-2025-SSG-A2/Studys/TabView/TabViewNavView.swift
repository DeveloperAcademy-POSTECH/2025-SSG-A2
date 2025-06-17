//
//  TabViewNavView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/17/25.
//

import SwiftUI

struct TabViewNavView: View {
    var body: some View {
      NavigationStack{
          List{
              NavigationLink("GyeongSubscriptView", destination: GyeongSubscriptView())
          }
          .navigationTitle("Tabview")
      }
    }
}

#Preview {
    TabViewNavView()
}
