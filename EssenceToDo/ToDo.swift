//
//  ToDo.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/24/22.
//

import Foundation

struct ToDo {
    
    private(set) var contents: [ToDoObject]
    
    private(set) var title: String 
    
    struct ToDoObject: Identifiable {
        var content: String
        let date: Date
        let id: Int
    }
    
    mutating func add(_ object: ToDoObject) {
        contents.append(object)
    }
    
    mutating func remove(at index: Int) {
        contents.remove(at: index)
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
