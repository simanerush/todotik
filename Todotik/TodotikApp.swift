//
//  TodotikApp.swift
//  Todotik
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI
import Firebase

@main
struct TodotikApp: App {
    let todo = Todotik(named: "Todotik")
    
    init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    
    var body: some Scene {
        WindowGroup {
            TodotikView(toDoList: todo)
        }
    }
}
