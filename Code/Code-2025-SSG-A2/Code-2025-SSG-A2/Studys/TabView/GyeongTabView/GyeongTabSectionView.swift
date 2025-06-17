//
//  GyeongTabSectionView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/17/25.
//

import SwiftUI

struct GyeongTabSectionView: View {
    var body: some View {
      TabView {
        Tab("Requests", systemImage: "paperplane") {
          RequestsView()
        }


        Tab("Account", systemImage: "person.crop.circle.fill") {
          AccountView()
        }


        TabSection("Messages") {
          Tab("Received", systemImage: "tray.and.arrow.down.fill") {
            ReceivedView()
          }


          Tab("Sent", systemImage: "tray.and.arrow.up.fill") {
            SentView()
          }


          Tab("Drafts", systemImage: "pencil") {
            DraftsView()
          }
        }
      }
      .tabViewStyle(.sidebarAdaptable)
    }
}

struct RequestsView: View {
  var body: some View {
    Text("Requests")
  }
}

struct DraftsView: View {
  var body: some View {
    Text("Drafts")
  }
}

#Preview {
  GyeongTabSectionView()
}
