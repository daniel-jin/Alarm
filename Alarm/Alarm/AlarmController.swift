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
    
    
    
}
