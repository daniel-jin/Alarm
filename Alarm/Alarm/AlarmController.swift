//
//  AlarmController.swift
//  Alarm
//
//  Created by Daniel Jin on 1/10/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
    
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Get up"
        notificationContent.body = "Open your eyes!"
        notificationContent.sound = UNNotificationSound.default()
        
        guard let fireDate = alarm.fireDate else { return }
        
        let dateComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: fireDate)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: dateTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request. \(error.localizedDescription)")
            }
        }
        
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        
    }
    
}

class AlarmController {
    
    // MARK: - Properties
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    // Mock data
    var mockAlarms: [Alarm] {
        return [Alarm(fireTimeFromMidnight: 890, name: "mockAlarm1"),
                Alarm(fireTimeFromMidnight: 1234, name: "mockAlarm2"),
                Alarm(fireTimeFromMidnight: 3333, name: "mockAlarm3", enabled: false),
                Alarm(fireTimeFromMidnight: 4444, name: "mockAlarm4"),
                Alarm(fireTimeFromMidnight: 5555, name: "mockAlarm5", enabled: false)]
    }
    
    init() {
        
        self.alarms = self.mockAlarms
        
        loadFromPersistantStore()
        
    }
    
    // Creates an alarm, adds to the alarms array, returns the alarm
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        
        alarms.append(alarm)
        
        saveToPersistantStore()
        
        return alarm
        
    }
    
    // Updates an existing alarm's fire time and date
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        
        saveToPersistantStore()
        
    }
    
    // Deletes and removes an alarm from the alarms array
    func delete(alarm: Alarm) {
        
        if alarms.contains(alarm) {
            
            guard let index = alarms.index(of: alarm) else { return }
            alarms.remove(at: index)
            
        }
        
        saveToPersistantStore()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        
        alarm.enabled = !alarm.enabled
        
        saveToPersistantStore()
        
    }
    
    // MARK: - Persistant store functions
    
    static private var persistentAlarmsFilePath: String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Alarms.plist")
    }
    
    func saveToPersistantStore() {
        
        guard let persistentAlarmsFilePath = AlarmController.persistentAlarmsFilePath else { return }
        
        NSKeyedArchiver.archiveRootObject(alarms, toFile: persistentAlarmsFilePath)
        
    }
    
    func loadFromPersistantStore() {
        
        guard let persistentAlarmsFilePath = AlarmController.persistentAlarmsFilePath else { return }
        
        NSKeyedUnarchiver.unarchiveObject(withFile: persistentAlarmsFilePath)
    }
}
