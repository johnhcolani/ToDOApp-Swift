//
//  TodoViewModel.swift
//  ToDoApp
//
//  Created by John Habibpour on 5/27/24.
//

import Foundation
import Combine

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []

    init() {
        fetchTodos()
    }

    func fetchTodos() {
        todos = DatabaseManager.shared.fetchTodos()
    }

    func addTodo(title: String, description: String) {
        DatabaseManager.shared.addTodo(title: title, description: description)
        fetchTodos()
    }

    func deleteTodo(id: Int64) {
        DatabaseManager.shared.deleteTodo(id: id)
        fetchTodos()
    }
    
    func updateTodo(id: Int64, title: String, description: String) {
        DatabaseManager.shared.updateTodo(id: id, title: title, description: description)
        fetchTodos()
    }
}


