//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Daniel Jin on 1/9/18.
//  Copyright © 2018 Daniel Jin. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    
    func switchCellSwitchValueChanged(alarm: Alarm, isOn: Bool)
    
}

class SwitchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    // MARK: - IBOutlets & IBActions
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        
        guard let alarm = alarm else { return }
        
        delegate?.switchCellSwitchValueChanged(alarm: alarm, isOn: alarm.enabled)
        
    }
    
    func updateViews() {
        
        guard let alarm = alarm else { return }
        
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
