//
//  Environment.swift
//  Swift Deep Dive
//
//  Created by 정희균 on 5/15/25.
//

import SwiftUI

@Observable
class Library {
    var books: [String] = ["SwiftUI", "Combine", "Swift"]
    
}

struct EnvironmentView: View {
    @State private var library = Library()

    // EnvironmentValues
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if colorScheme == .light {
                Text("Light Mode")
                
            } else {
                Text("Dark Mode")
                
            }
            EnvironmentSubView()
        }
        .environment(library)
    }
}

struct EnvironmentSubView: View {
    // Custom Environment
    @Environment(Library.self) private var library
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Library")
                .font(.headline)
                .padding(.bottom)
            
            ForEach(library.books, id: \.self) { book in
                Text(book)
            }
        }
        .padding()
        .background(.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EnvironmentView()
}
