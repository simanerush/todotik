//
//  ToDoObjectEditor.swift
//  Todotik
//
//  Created by Sima Nerush on 4/16/22.
//

import SwiftUI

struct ToDoObjectEditor: View {
    
    @Binding var objectToEdit: ToDo.ToDoObject
    
    var body: some View {
        Form {
            nameSection
            dateSection
        }
        
    }
    
    var nameSection: some View {
        Section(header: Text("New To-Do")) {
            TextField("Contents", text: $objectToEdit.content)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    var dateSection: some View {
        if objectToEdit.date != nil {
            HStack {
                Section(header: Text("Date Due")) {
                    DatePicker("Date", selection: Binding($objectToEdit.date)!, displayedComponents: [.date])
                }
                Button {
                    objectToEdit.date = nil
                } label: {
                    Image(systemName: "minus.circle.fill").foregroundColor(.accentColor)
                }
            }
        } else {
            Button("Add due date") {
                objectToEdit.date = .now
            }
        }
    }
}
