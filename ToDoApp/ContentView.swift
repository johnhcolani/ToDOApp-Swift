//
//  ContentView.swift
//  ToDoApp
//
//  Created by John Habibpour on 5/27/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TodoViewModel()
    @State private var title = ""
    @State private var description = ""
    @State private var editingTodo: Todo? = nil

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.todos) { todo in
                        VStack(alignment: .leading) {
                            Text(todo.title).font(.headline)
                            Text(todo.description).font(.subheadline)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.deleteTodo(id: todo.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                editingTodo = todo
                                title = todo.title
                                description = todo.description
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
                }
                .listStyle(PlainListStyle())

                if editingTodo != nil {
                    VStack {
                        TextField("Title", text: $title)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        TextField("Description", text: $description)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        HStack {
                            Button(action: {
                                if let todo = editingTodo {
                                    viewModel.updateTodo(id: todo.id, title: title, description: description)
                                    editingTodo = nil
                                    title = ""
                                    description = ""
                                }
                            }) {
                                Text("Save")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(8)
                            }

                            Button(action: {
                                editingTodo = nil
                                title = ""
                                description = ""
                            }) {
                                Text("Cancel")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.red)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                } else {
                    VStack {
                        TextField("Title", text: $title)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        TextField("Description", text: $description)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)

                        Button(action: {
                            if !title.isEmpty && !description.isEmpty {
                                viewModel.addTodo(title: title, description: description)
                                title = ""
                                description = ""
                            }
                        }) {
                            Text("Add To-Do")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    
                }
            }
            .navigationBarTitle("To-Do List", displayMode: .inline)
            
        }
    }
}
