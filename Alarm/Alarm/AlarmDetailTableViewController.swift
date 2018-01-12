//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Daniel Jin on 1/9/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        
        guard let alarm = self.alarm else { return }
        
        AlarmController.shared.toggleEnabled(for: alarm)
        
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let alarmTitle = alarmNameTextField.text,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        
        let timeInterval = datePicker.date.timeIntervalSince(thisMorningAtMidnight)
        
        // Alarm exists - update and save
        if let alarm = alarm {
            cancelUserNotifications(for: alarm)
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeInterval, name: alarmTitle)
            scheduleUserNotifications(for: alarm)
        } else {
            // Alarm doesn't exist -- create new alarm
            AlarmController.shared.addAlarm(fireTimeFromMidnight: timeInterval, name: alarmTitle)
            let newAlarm = Alarm(fireTimeFromMidnight: timeInterval, name: alarmTitle)
            scheduleUserNotifications(for: newAlarm)
        }
        
        
        
        
    }
    
    
    func updateViews() {
        
        if let alarm = self.alarm {
            
            alarmNameTextField?.text = alarm.name
            
            datePicker.date = alarm.fireDate!
            
            if alarm.enabled {
                enableButton.setTitle("Disable", for: .normal)
                enableButton.setTitleShadowColor(UIColor.red, for: .normal)
                
            } else {
                enableButton.setTitle("Enable", for: .normal)
                enableButton.setTitleShadowColor(UIColor.green, for: .normal)
            }
            
        } else { // if alarm is nil, hide enable/disable button
            enableButton.isHidden = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
