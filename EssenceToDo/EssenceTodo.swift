//
//  EssenceTodo.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/24/22.
//

import SwiftUI

class EssenceToDo: ObservableObject {
    
    static func createToDo() -> ToDo {
        ToDo(contents: [])
    }
    
    @Published private var model: ToDo = createToDo()
    
    var contents: Array<ToDo.ToDoObject> {
        return model.contents 
    }
    
    // MARK: - Intents
    
    func add(_ object: ToDo.ToDoObject) {
        model.add(object)
    }
    
    func remove(at index: Int) {
        model.remove(at: index)
    }
    
    func edit(_ object: ToDo.ToDoObject, newContent: String) {
        model.edit(object: object, newContent: newContent)
    }
}
