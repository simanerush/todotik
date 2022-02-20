//
//  AddToDoView.swift
//  Todotik
//
//  Created by Serafima Nerush on 2/18/22.
//

import SwiftUI

struct AddToDoView: View {
    
    @ObservedObject var todoList: Todotik
    @Environment(\.presentationMode) private var presentationMode
    @State private var content = ""
    @State private var date: Date? = nil
    
    func addNewTodo() {
        var newTodo = ToDo.ToDoObject(content: content, date: date, id: 0)
        todoList.add(&newTodo)
        presentationMode.wrappedValue.dismiss()
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        Form {
            nameSection
            dateSection
            submitSection
        }
        
    }
    
    var nameSection: some View {
        Section(header: Text("New To-Do")) {
            TextField("Contents", text: $content)
                .modifier(TextFieldClearButton(text: $content))
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    var dateSection: some View {
        if date != nil {
            HStack {
                Section(header: Text("Date Due")) {
                    DatePicker("Date", selection: Binding($date)!, displayedComponents: [.date])
                }
                Button {
                    date = nil
                } label: {
                    Image(systemName: "minus.circle.fill").foregroundColor(.accentColor)
                }
            }
        } else {
            Button("Add due date") {
                date = .now
            }
        }
    }
    
    var submitSection: some View {
        Button(action: addNewTodo) {
            Text("Add New Todo")
        }
        .disabled(content.isEmpty)
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(todoList: Todotik(named: "Preview"))
    }
}
