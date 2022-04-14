//
//  AddRegistrationTableViewController.swift
//  complexInput
//
//  Created by Nathan Lambson on 10/28/21.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    
    @IBOutlet weak var checkOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    
    var isCheckOutDatePickerVisible: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNumberOfGuests()
        updateDateViews()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
    }
    
    func updateDateViews() {
        //You have to check out AFTER you check in by atleast one day
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
        
        checkInDateLabel.text = dateFormatter.string(from:
           checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from:
           checkOutDatePicker.date)
    }
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
        
    }
    
    //MARK: UITableViewDelegate Methods
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
          case checkInDatePickerCellIndexPath where
            isCheckInDatePickerVisible == false:
            return 0
          case checkOutDatePickerCellIndexPath where
            isCheckOutDatePickerVisible == false:
            return 0
          default:
            return UITableView.automaticDimension
          }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == checkInDateLabelCellIndexPath &&
           isCheckOutDatePickerVisible == false {
            // check-in label selected, check-out picker is not visible, toggle check-in picker
            isCheckInDatePickerVisible.toggle()
        } else if indexPath == checkOutDateLabelCellIndexPath &&
           isCheckInDatePickerVisible == false {
            // check-out label selected, check-in picker is not visible, toggle check-out picker
            isCheckOutDatePickerVisible.toggle()
        } else if indexPath == checkInDateLabelCellIndexPath ||
           indexPath == checkOutDateLabelCellIndexPath {
            // either label was selected, previous conditions failed meaning at least one picker is visible, toggle both
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible.toggle()
        } else {
            return
        }
        
        tableView.reloadData()
    }
    
    //MARK: IBActions

    @IBAction func doneBarButtonTapped(_ sender: Any) {
        let firstName = firstNameField.text ?? ""
        let lastName = lastNameField.text ?? ""
        let email = emailField.text ?? ""
        let checkIndate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        print("firstName: \(firstName)")
        print("lastName: \(lastName)")
        print("email: \(email)")
        print("checkIn: \(checkIndate)")
        print("checkOut: \(checkOutDate)")
        print("numberOfAdults: \(numberOfAdults)")
        print("numberOfChildren: \(numberOfChildren)")
        print("wifi: \(hasWifi)")
    }
    
    @IBAction func checkInDateValueChanged(_ sender: Any) {
        updateDateViews()
    }
    
    @IBAction func checkOutDateValueChanged(_ sender: Any) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        updateNumberOfGuests()
    }
    
    @IBAction func wifiSwitchChanged(_ sender: Any) {
        //nothing here yet
    }
}

