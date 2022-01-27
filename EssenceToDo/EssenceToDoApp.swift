//
//  EssenceToDoApp.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI

@main
struct EssenceToDoApp: App {
    let todo = EssenceToDo()
    var body: some Scene {
        WindowGroup {
            EssenceToDoView(toDoList: todo)
        }
    }
}
