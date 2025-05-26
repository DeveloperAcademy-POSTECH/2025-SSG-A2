//
//  MVVMView.swift
//  Code-2025-SSG-A2
//
//  Created by Miru on 2025/5/26.
//

import SwiftUI

struct Week2MiruTodoView: View { // View
    @StateObject var viewModel = Week2MiruTodoViewModel()
    @State private var newTodoTitle = ""

    var body: some View {
        
        VStack {
            
            HStack {
                TextField("할 일 입력", text: $newTodoTitle)
                
                Button {
                    viewModel.add(title: newTodoTitle)
                    newTodoTitle = ""
                } label: {
                    Text("추가")
                }
            }

            List {
                ForEach(viewModel.todos) { todo in
                    HStack {
                        Text(todo.title)
                        Spacer()
                        Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                            .onTapGesture {
                                viewModel.toggleTodo(todo)
                            }
                    }
                }
            }
        }
        .padding()
        
    }
}

struct Week2MiruTodo: Identifiable { // Model
    let id = UUID()
    var title: String
    var isDone: Bool
}

class Week2MiruTodoViewModel: ObservableObject { // ViewModel
    @Published var todos: [Week2MiruTodo] = []
    
    func add(title: String) {
        let todo = Week2MiruTodo(title: title, isDone: false)
        todos.append(todo)
    }
    
    func toggleTodo(_ todo: Week2MiruTodo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isDone.toggle()
        }
    }
    
}

#Preview {
    Week2MiruTodoView()
}
