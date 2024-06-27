//
//  DatabaseManager.swift
//  ToDoApp
//
//  Created by John Habibpour on 5/27/24.
//

import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    private var db: Connection?

    private let todos = Table("todos")
    private let id = Expression<Int64>("id")
    private let title = Expression<String>("title")
    private let description = Expression<String>("description")

    private init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlite3")
            try db?.run(todos.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(title)
                t.column(description)
            })
        } catch {
            print("Unable to create/open database: \(error)")
        }
    }

    func fetchTodos() -> [Todo] {
        var todoList = [Todo]()
        do {
            for todo in try db!.prepare(todos) {
                todoList.append(Todo(
                    id: todo[id],
                    title: todo[title],
                    description: todo[description]
                ))
            }
        } catch {
            print("Failed to fetch todos: \(error)")
        }
        return todoList
    }

    func addTodo(title: String, description: String) {
        do {
            let insert = todos.insert(self.title <- title, self.description <- description)
            try db?.run(insert)
        } catch {
            print("Failed to add todo: \(error)")
        }
    }

    func deleteTodo(id: Int64) {
        do {
            let todo = todos.filter(self.id == id)
            try db?.run(todo.delete())
        } catch {
            print("Failed to delete todo: \(error)")
        }
    }
    
    func updateTodo(id: Int64, title: String, description: String) {
        do {
            let todo = todos.filter(self.id == id)
            try db?.run(todo.update(self.title <- title, self.description <- description))
        } catch {
            print("Failed to update todo: \(error)")
        }
    }
}
