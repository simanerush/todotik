//
//  ToDo.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/24/22.
//

import Foundation

struct ToDo: Codable {
    
    var contents: [ToDoObject]
    
    struct ToDoObject: Identifiable, Codable {
        var content: String
        var date: Date
        var id: Int
        
        func dateFormatted() -> String {
            return self.date.formatted()
        }
    }
    
    private func findMaxIdObject() -> ToDoObject? {
        return contents.max { $0.id < $1.id }
    }
    
    mutating func add(_ object: inout ToDoObject) {
        let maxObject = findMaxIdObject()
        
        if let maxObject = maxObject {
            object.id = maxObject.id + 1
        } else {
            object.id = 0
        }
       
        contents.append(object)
    }
    
    mutating func edit(object: ToDoObject, newContent: String) {
        let objectIndex = contents.index(matching: object)
        contents[objectIndex!].content = newContent
    }
}

extension Collection where Element: Identifiable, Self.Element.ID: BinaryInteger {
    func index(matching element: Element) -> Self.Index? {
        firstIndex(where: { $0.id == element.id })
    }
    
    func getElement(at index: Int) -> Element? {
        first(where: { $0.id == index })
    }
}
