//
//  ContentView.swift
//  Code-2025-SSG-A2
//
//  Created by 산들 on 7/12/25.
//

import SwiftUI
import SwiftData

struct SandeulModelcontainerView: View {
    // 1. 데이터 작업을 위한 ModelContext 환경 변수
    @Environment(\.modelContext) private var modelContext
    
    // 2. 데이터베이스에서 Todo 항목들을 가져와 createdAt 기준으로 정렬
    @Query(sort: \Todo.createdAt, order: .reverse) private var todos: [Todo]
    
    // 3. 새로운 할 일을 입력받기 위한 상태 변수
    @State private var newTodoContent: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                // 할 일 목록 표시
                List {
                    ForEach(todos) { todo in
                        HStack {
                            // 완료 여부 토글
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todo.isCompleted ? .green : .gray)
                                .onTapGesture {
                                    toggleTodoCompletion(todo)
                                }
                            
                            // 할 일 내용
                            Text(todo.content)
                                .strikethrough(todo.isCompleted, color: .gray)
                            
                            Spacer()
                        }
                    }
                    .onDelete(perform: deleteTodo) // 스와이프로 삭제
                }
                
                // 새로운 할 일 추가 영역
                HStack {
                    TextField("새로운 할 일을 입력하세요", text: $newTodoContent)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit(addTodo) // 엔터 키로 추가
                    
                    Button(action: addTodo) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                    .disabled(newTodoContent.isEmpty)
                }
                .padding()
            }
            .navigationTitle("📝 할 일 목록")
            .toolbar {
                EditButton() // 목록 편집(삭제) 모드 활성화
            }
        }
    }
    
    // CREATE: 새로운 할 일 추가
    private func addTodo() {
        guard !newTodoContent.isEmpty else { return }
        let newTodo = Todo(content: newTodoContent)
        modelContext.insert(newTodo)
        newTodoContent = ""
    }
    
    // UPDATE: 할 일 완료 상태 변경
    private func toggleTodoCompletion(_ todo: Todo) {
        todo.isCompleted.toggle()
        // SwiftData가 자동으로 변경사항을 감지하므로, 명시적인 save 호출이 필수는 아님
        try? modelContext.save()
    }

    // DELETE: 할 일 삭제
    private func deleteTodo(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todos[index])
        }
    }
}

#Preview {
    SandeulModelcontainerView()
        // 프리뷰를 위해 인메모리 컨테이너 설정
        .modelContainer(for: Todo.self, inMemory: true)
}
