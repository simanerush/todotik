//
//  TodotikView.swift
//  Todotik
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI

struct TodotikView: View {
    
    @ObservedObject var toDoList: Todotik
    
    init(toDoList: Todotik) {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "FiraCode-Bold", size: 40)!]
        
        self.toDoList = toDoList
        //Use this if NavigationBarTitle is with displayMode = .inline
        //UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach($toDoList.contents) { $object in
                    NavigationLink(destination: ToDoObjectEditor(objectToEdit: $object).navigationBarTitle("", displayMode: .inline)) {
                        VStack(alignment: .leading) {
                            Text(object.content)
                            Text("Due \(object.dateFormatted())").foregroundColor(.gray)
                        }.font(FontAshot.commonFont(fontSize: 16))
                    }
                }
                .onDelete { indexSet in
                    toDoList.contents.remove(atOffsets: indexSet)
                }
                
            }
            .navigationBarTitle(Text(toDoList.name).font(.subheadline), displayMode: .large)
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
                    .modifier(TextFieldClearButton(text: $objectToEdit.content))
                    .multilineTextAlignment(.leading)
            }
        }
        
        var dateSection: some View {
            Section(header: Text("Date Due")) {
                DatePicker("Date", selection: $objectToEdit.date, displayedComponents: [.date])
            }
        }
    }
}



struct TodotikView_Previews: PreviewProvider {
    static var previews: some View {
        TodotikView(toDoList: Todotik(named: "Preview"))
    }
}
