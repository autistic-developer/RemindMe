//
//  AlarmManager.swift
//  Clock
//
//  Created by Lalit Vinde on 04/08/23.
//

import Foundation
import UserNotifications
import UIKit
import EventKit

class ReminderManager : NSObject, ObservableObject{
    
    static let shared = ReminderManager()
    private let calendar = Calendar.current
    @MainActor let eventStore = EKEventStore()
    @MainActor @Published var isUpdated:Bool = false
    @MainActor @Published var isGranted:Bool = false
    
    override init(){
        super.init()
        Task{
            await setIsGrantedStatus()
        }
    }
  
    //MARK: fetch reminders
    func fetchReminders(completion: @escaping (_:[EKReminder]?) -> Void) async{
        guard await isGranted else{ return }
        let predicate = eventStore.predicateForReminders(in: nil)
        eventStore.fetchReminders(matching: predicate, completion: completion)
    }
    
    // MARK: request authorization
    func requestAuthorization(){
        let authorizationStatus = EKEventStore.authorizationStatus(for: .reminder)
       
        if authorizationStatus == .notDetermined{
            requestAccess()
        }
        else if  authorizationStatus == .denied{
            Task{
                await openSettings()
            }
        }
        
    }
    
    // MARK: request access
    private func requestAccess() {
        eventStore.requestFullAccessToReminders { granted, error in
            Task{[weak self] in
                await self?.setIsGrantedStatus()
                self?.eventStore.reset()
            }
        }
        
        
        
        
    }
    
    // MARK: open settings
    @MainActor private func openSettings(){
        
        if let url = URL(string: UIApplication.openSettingsURLString){
            if UIApplication.shared.canOpenURL(url){
                Task{
                    await UIApplication.shared.open(url)
                }
            }
        }
        
    }
    
    // MARK: set is granted
    @MainActor func setIsGrantedStatus(){
        Task{
            let authorizationStatus = EKEventStore.authorizationStatus(for: .reminder)
            isGranted = authorizationStatus == .fullAccess
        }
    }
    
    // MARK: set alarm
    func setReminder(date: Date, title: String?, notes: String?) async -> Bool{
            if await isGranted{
                let ekReminder = EKReminder(eventStore: eventStore)
                
                ekReminder.title = title
                ekReminder.notes = notes
                
                
                let dueDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                ekReminder.dueDateComponents = dueDateComponents
                
               
                // Set the calendar (optional, use default calendar if not specified)
                ekReminder.calendar = eventStore.defaultCalendarForNewReminders()
                
                do {
                    // Save the reminder
                    try eventStore.save(ekReminder, commit: true)
                    eventStore.reset()
                    Task{
                        await MainActor.run{
                            isUpdated.toggle()
                        }
                        
                    }
                    return true
                } catch {
                    return false
                }
            }
        
        return false
    }
    func deleteReminder(reminder:EKReminder){
        Task{
            if await isGranted{
                do{
                    try eventStore.remove(reminder, commit: true)
                    eventStore.reset()

                    Task{
                        await MainActor.run{
                            isUpdated.toggle()
                        }
                        
                    }
                }
                catch {
                    fatalError("\(error.localizedDescription)")
                }
            }
        }
    }
    
}
