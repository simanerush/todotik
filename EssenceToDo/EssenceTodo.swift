//
//  EssenceTodo.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/24/22.
//

import SwiftUI

class EssenceToDo: ObservableObject {
    
    static func createToDo() -> ToDo {
        ToDo(contents: [ToDo.ToDoObject(content: "Test", date: .now, id: 1)], title: "Test To Do")
    }
    
    @Published private var model: ToDo = createToDo()
    
    var contents: Array<ToDo.ToDoObject> {
        get {
            return model.contents
        } set {
            model.contents = newValue
        }
    } 
    
    var title: String {
        return model.title
    }
    
    // MARK: - Intents
    
    func add(_ object: inout ToDo.ToDoObject) {
        model.add(&object)
    }
    
    func remove(at index: Int) {
        model.remove(at: index)
    }
    
    func edit(_ object: ToDo.ToDoObject, newContent: String) {
        model.edit(object: object, newContent: newContent)
    }
}
