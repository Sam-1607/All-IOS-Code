//
//  ViewController.swift
//  Alarm
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var alarmLabel: UILabel!
    
    @IBOutlet var scheduleButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .alarmUpDated, object: nil)

    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    @objc func updateUI() {
        if let scheduledAlarm = Alarm.scheduled {
            let formattedAlarm = dateFormatter.string(from: scheduledAlarm.date)
            alarmLabel.text = "Your Alarm is scheduled for \(formattedAlarm)"
            datePicker.isEnabled = false
            scheduleButton.setTitle("Remove Alarm", for: .normal)
        } else {
            alarmLabel.text = "Set an alarm label below"
            datePicker.isEnabled = true
            scheduleButton.setTitle("Set Alarm", for: .normal)
        }
    }
    
    func presentNeedAuthorizationAlert() {
        let title = "Authorization Needed"
        let message = "Alarms don't work without notifications, and it looks like you haven't granted us permession to send you those. Please go to the iOS setting app and grant us notification permession."
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }

    @IBAction func setAlarmButtonTapped(_ sender: UIButton) {
        
        if let alarm = Alarm.scheduled {
            alarm.unschedule()
        } else {
            let alarm = Alarm(date: datePicker.date)
            alarm.schedule { [weak self] (permissionGranted) in
                if !permissionGranted {
                    self?.presentNeedAuthorizationAlert()
                }
            }
        }

    }
}

