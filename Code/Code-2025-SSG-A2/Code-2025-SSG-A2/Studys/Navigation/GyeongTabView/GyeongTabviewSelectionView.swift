//
//  GyheongTabviewSelectionView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/22/25.
//

import SwiftUI

struct GyeongTabviewSelectionView: View {
  @State private var selectedTab = 1
  
  var body: some View {
    TabView(selection: $selectedTab) {
      Tab("Received", systemImage: "tray.and.arrow.down.fill", value: 1) {
        SelectionView(selection: selectedTab)
      }
      
      Tab("Sent", systemImage: "tray.and.arrow.up.fill", value: 2) {
        SelectionView(selection: selectedTab)
      }
      
      Tab("Account", systemImage: "person.crop.circle.fill", value: 3) {
        SelectionView(selection: selectedTab)
      }
    }
    .tabViewStyle(.page)
  }
}

struct SelectionView: View {
  var selection: Int
  var body: some View {
    switch selection {
      case 1:
      Text("Received")
      case 2:
      Text("Sent")
      default:
      Text("Account")
    }
  }
}

#Preview {
    GyeongTabviewSelectionView()
}
