//
//  GyeongTabviewExampleView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/19/25.
//

import SwiftUI

struct GyeongTabviewExampleView: View {
    var body: some View {
      TabView {
        Tab("Recieived", systemImage: "tray.and.arrow.down.fill") {
          ReceivedView()
        }
        .badge(2)
        
        Tab("Sent", systemImage: "tray.and.arrow.up.fill") {
          SentView()
        }
        
        Tab("Account", systemImage: "person.crop.circle.fill") {
          AccountView()
        }
        .badge("!")
      }
    }
}

struct ReceivedView: View {
  var body: some View {
    Text("Received")
  }
}

struct SentView: View {
  var body: some View {
    Text("Sent")
  }
}

struct AccountView: View {
  var body: some View {
    Text("Account")
  }
}

#Preview {
    GyeongTabviewExampleView()
}
