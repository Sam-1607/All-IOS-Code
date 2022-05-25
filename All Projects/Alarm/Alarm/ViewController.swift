//
//  ViewController.swift
//  Alarm
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var alarmLabel: UILabel!
    
    @IBOutlet var scheduleButton: UIButton!
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    @objc func upDateUI() {
        if let scheduledAlarm = Alarm.scheduled {
            let formattedAlarm = dateFormatter.string(from: scheduledAlarm.date)
            alarmLabel.text = "Your alarm is scheduled for \(formattedAlarm)"
            datePicker.isEnabled = false
            scheduleButton.setTitle("Remmove Alarm", for: .normal)
        } else {
            alarmLabel.text = "Set an alarm label below"
            datePicker.isEnabled = true
            scheduleButton.setTitle("Set Alarm", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        upDateUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(upDateUI), name: .alarmUpdated, object: nil)

    }

    @IBAction func setAlarmButtonTapped(_ sender: UIButton) {

    }
}

