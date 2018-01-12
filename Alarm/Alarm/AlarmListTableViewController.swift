//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Daniel Jin on 1/9/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func switchCellSwitchValueChanged(alarm: Alarm, isOn: Bool) {
        
        AlarmController.shared.toggleEnabled(for: alarm)
        
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        
        tableView.reloadData()
        
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.shared.alarms.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell else { return UITableViewCell()}

        let alarm = AlarmController.shared.alarms[indexPath.row]
        
        cell.alarm = alarm
        
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let alarm = AlarmController.shared.alarms[indexPath.row]
            
            AlarmController.shared.delete(alarm: alarm)
            
            cancelUserNotifications(for: alarm)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "toAlarmDetails" {
            
            guard let alarmDetailTVC = segue.destination as? AlarmDetailTableViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let alarm = AlarmController.shared.alarms[indexPath.row]
            
            alarmDetailTVC.alarm = alarm
            
        }
        
    }
    

}
