//
//  ToDoObjectEditor.swift
//  Todotik
//
//  Created by Sima Nerush on 4/16/22.
//

import SwiftUI

struct ToDoObjectEditor: View {
    
    @Binding var objectToEdit: ToDo.ToDoObject
    
    @State private var date: Date? = nil
    @State private var notificationDate = Date()
    @State private var notificationSectionDisplayed = false
    @State private var notificationAdded = false
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 2022, month: 1, day: 1)
        let endComponents = DateComponents(year: 2122, month: 12, day: 31)
        return calendar.date(from:startComponents)!...calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        Form {
            nameSection
            dateSection
            notificationButton
            notificationSection
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
    
    @ViewBuilder
    var notificationButton: some View {
        if !notificationSectionDisplayed {
            Button {
                notificationSectionDisplayed.toggle()
            } label: {
                Text("Add Notification")
            }
        }
        
    }
    
    func addNotification(from notificationDate: Date) {
        let content = UNMutableNotificationContent()
        content.title = objectToEdit.content
        content.subtitle = "Make Todotik happy!!!"
        content.sound = UNNotificationSound.default
        
        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        let weekday = Calendar.current.component(.weekday, from: notificationDate)
        let hour = Calendar.current.component(.hour, from: notificationDate)
        let minute = Calendar.current.component(.minute, from: notificationDate)
        
        dateComponents.weekday = weekday
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: false)
        
        // Create the request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                objectToEdit.notifications.append(notificationDate)
            }
        }
    }
    
    @ViewBuilder
    var notificationSection: some View {
        if notificationSectionDisplayed && !notificationAdded {
            VStack {
                DatePicker(
                    "Start Date",
                    selection: $notificationDate,
                    in: dateRange,
                    displayedComponents: [.date, .hourAndMinute]
                )
                Button {
                    addNotification(from: notificationDate)
                    notificationAdded.toggle()
                } label: {
                    Text("Schedule Notification")
                }
            }
 
        }
        else if notificationAdded || !objectToEdit.notifications.isEmpty {
            Text("Notification Scheduled at \(objectToEdit.notifications.last!.formatted())")
        }
    }
}
