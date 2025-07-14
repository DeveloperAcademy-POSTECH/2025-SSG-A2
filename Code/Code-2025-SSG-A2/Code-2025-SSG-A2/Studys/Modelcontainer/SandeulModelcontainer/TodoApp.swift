//
//  111.swift
//  Code-2025-SSG-A2
//
//  Created by 산들 on 7/12/25.
//

import SwiftUI
import SwiftData

struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            SandeulModelcontainerView()
        }
        .modelContainer(for: Todo.self)
    }
}
