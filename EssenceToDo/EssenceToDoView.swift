//
//  EssenceToDoView.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI

struct EssenceToDoView: View {
    
    @ObservedObject var toDoList: EssenceToDo
    
    var body: some View {
        NavigationView {
            List {
                ForEach(toDoList.contents) { object in
                    
                    Text(object.content)
                }
            }
        }.navigationTitle(toDoList.title)
    }
}

struct EssenceToDoView_Previews: PreviewProvider {
    static var previews: some View {
        EssenceToDoView(toDoList: EssenceToDo())
    }
}
