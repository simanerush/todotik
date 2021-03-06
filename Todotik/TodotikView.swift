//
//  TodotikView.swift
//  Todotik
//
//  Created by Serafima Nerush on 1/22/22.
//

import SwiftUI
import UserNotifications

struct TodotikView: View {
    
    @ObservedObject var toDoList: Todotik
    @State private var showingSheet = false
    @State private var textField = ""
    @State private var date: Date? = nil
    @State private var notificationDate = Date()
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2022, month: 1, day: 1)
        let endComponents = DateComponents(year: 2122, month: 12, day: 31)
        return calendar.date(from:startComponents)!...calendar.date(from:endComponents)!
    }()
    
    
    init(toDoList: Todotik) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "FiraCode-Bold", size: 40)!]
        
        self.toDoList = toDoList
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        TextField("New To-Do", text: $textField)
                        Button {
                            if !textField.isEmpty {
                                var newTodo = ToDo.ToDoObject(content: textField, date: date, id: 0, notifications: [])
                                toDoList.add(&newTodo)
                                textField = ""
                            }
                        } label: {
                            Label("", systemImage: "plus")
                        }
                    }
                    ForEach($toDoList.contents) { $object in
                        NavigationLink(destination: ToDoObjectEditor(objectToEdit: $object).navigationBarTitle("", displayMode: .inline)) {
                            VStack(alignment: .leading) {
                                Text(object.content)
                                Text(object.dateFormatted()).foregroundColor(.gray)
                            }.font(FontAshot.commonFont(fontSize: 16))
                        }
                    }
                    .onDelete { indexSet in
                        toDoList.contents.remove(atOffsets: indexSet)
                    }
                }
                .navigationTitle(Text(toDoList.name).font(.subheadline))
            }
        }
    }
}



struct TodotikView_Previews: PreviewProvider {
    static var previews: some View {
        TodotikView(toDoList: Todotik(named: "Preview"))
    }
}

