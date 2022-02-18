//
//  TodotikApp.swift
//  Todotik
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI

@main
struct TodotikApp: App {
    let todo = Todotik(named: "To Do Name")
    var body: some Scene {
        WindowGroup {
            TodotikView(toDoList: todo).onAppear {
                for family in UIFont.familyNames.sorted() {
                    let names = UIFont.fontNames(forFamilyName: family)
                    print("Family: \(family) Font names: \(names)")
                }
            }
        }
    }
}
