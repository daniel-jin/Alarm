//
//  AlarmController.swift
//  Alarm
//
//  Created by Daniel Jin on 1/10/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import Foundation

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
        
    }
    
    // Creates an alarm, adds to the alarms array, returns the alarm
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        
        alarms.append(alarm)
        
        return alarm
        
    }
    
    // Updates an existing alarm's fire time and date
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        
    }
    
    // Deletes and removes an alarm from the alarms array
    func delete(alarm: Alarm) {
        
        if alarms.contains(alarm) {
            
            guard let index = alarms.index(of: alarm) else { return }
            alarms.remove(at: index)
            
        }
    }
    
    func toggleEnabled(for alarm: Alarm) {
        
        alarm.enabled = !alarm.enabled
        
    }
    
    
    
}
