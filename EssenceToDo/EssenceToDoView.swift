//
//  EssenceToDoView.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI

struct EssenceToDoView: View {
    
    @ObservedObject var toDoList: EssenceToDo
    
    @State var objectToEdit: ToDo.ToDoObject?
    @State var editing = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(toDoList.contents) { object in
                    VStack(alignment: .leading) {
                        Text(object.content)
                        Text(object.dateFormatted())
                    }
                    .onTapGesture {
                        objectToEdit = object
                        editing = true
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
                .sheet(isPresented: $editing) {
                    ToDoObjectEditor(toDoObject: Binding($objectToEdit)!)
                }

            }
        }
        
    }
    
    struct ToDoObjectEditor: View {
        
        @Binding var toDoObject: ToDo.ToDoObject
        
        
        var body: some View {
            Form {
                contentSection
            }
        }
        
        var contentSection: some View {
            Form {
                nameSection
                dateSection
            }
            .frame(width: 500, height: 500, alignment: .center)
            
        }
        
        var nameSection: some View {
            Section(header: Text("New To-Do")) {
                TextField("Contents", text: $toDoObject.content)
            }
        }
        
        var dateSection: some View {
            Section(header: Text("Date Due")) {
                DatePicker("Date", selection: $toDoObject.date, displayedComponents: [.date])
            }
        }
    }
}



struct EssenceToDoView_Previews: PreviewProvider {
    static var previews: some View {
        EssenceToDoView(toDoList: EssenceToDo(named: "Preview"))
    }
}

