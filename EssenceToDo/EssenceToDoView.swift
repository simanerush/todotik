//
//  EssenceToDoView.swift
//  EssenceToDo
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI

struct EssenceToDoView: View {
    
    @ObservedObject var toDoList: EssenceToDo
    
    @State var objectToEdit: ToDo.ToDoObject = ToDo.ToDoObject(content: "test", date: .now, id: 100)
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
                        editing.toggle()
                        print("Set objectToEdit to \(object)")
                        print("objectToEdit = \(objectToEdit)")
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
                    ToDoObjectEditor(objectToEdit: $objectToEdit)
                }

            }
        }
        
    }
    
    struct ToDoObjectEditor: View {
        
        @Binding var objectToEdit: ToDo.ToDoObject
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            Form {
                nameSection
                dateSection
            }
            
        }
        
        var nameSection: some View {
            Section(header: Text("New To-Do")) {
                TextField("Contents", text: $objectToEdit.content, onCommit:  { self.presentationMode.wrappedValue.dismiss()})
            }
        }
        
        var dateSection: some View {
            Section(header: Text("Date Due")) {
                DatePicker("Date", selection: $objectToEdit.date, displayedComponents: [.date])
            }
        }
    }
}



struct EssenceToDoView_Previews: PreviewProvider {
    static var previews: some View {
        EssenceToDoView(toDoList: EssenceToDo(named: "Preview"), objectToEdit: ToDo.ToDoObject(content: "Preview", date: .now, id: 100))
    }
}

