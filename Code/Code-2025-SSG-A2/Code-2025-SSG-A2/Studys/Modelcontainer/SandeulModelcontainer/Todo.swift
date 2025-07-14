//
//  File.swift
//  Code-2025-SSG-A2
//
//  Created by 산들 on 7/12/25.
//

import Foundation
import SwiftData

@Model
final class Todo {
    var id: UUID
    var content: String
    var isCompleted: Bool
    var createdAt: Date

    init(content: String) {
        self.id = UUID()
        self.content = content
        self.isCompleted = false
        self.createdAt = Date()
    }
}
