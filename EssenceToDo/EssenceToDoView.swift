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
                    NavigationLink(destination: ToDoObjectCreator(toDoObject: $toDoList.contents[object.id])) {
                        VStack(alignment: .leading) {
                            Text(object.content)
                            Text(object.dateFormatted())
                        }
                    }
                }
                .onDelete { indexSet in
                    toDoList.contents.remove(atOffsets: indexSet)
                }
            } .navigationTitle(toDoList.name)
              .toolbar {
                Button {
                    @State var newObject = ToDo.ToDoObject(content: "New ToDo", date: .now, id: 0)
                    toDoList.add(&newObject)
                } label: {
                    Label("New", systemImage: "plus")
                }
            }
        }
        
    }
    
    struct ToDoObjectCreator: View {
        
        @Binding var toDoObject: ToDo.ToDoObject
        
        var body: some View {
            Form {
                contentSection
            }
        }
        
        var contentSection: some View {
            Section(header: Text("New To-Do")) {
                TextField("Contents", text: $toDoObject.content)
            }
        }
    }
}



struct EssenceToDoView_Previews: PreviewProvider {
    static var previews: some View {
        EssenceToDoView(toDoList: EssenceToDo(named: "Preview"))
    }
}

