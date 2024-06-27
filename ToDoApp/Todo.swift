//
//  Todo.swift
//  ToDoApp
//
//  Created by John Habibpour on 5/27/24.
//

import Foundation
import SQLite
struct Todo: Identifiable{
    var id:Int64
    var title:String
    var description: String
}
