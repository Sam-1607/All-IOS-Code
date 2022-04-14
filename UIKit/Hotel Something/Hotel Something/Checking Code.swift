////
////  Checking Code.swift
////  Hotel Something
////
////  Created by Sam Hiatt  on 10/28/21.
////
//
//import Foundation
//// AddRegistrationTableViewController.swift
//// HotelManzana
////
//// Created by Reece Olsen on 10/28/21.
////
//import UIKit
//class AddRegistrationTableViewController: UITableViewController {
//  @IBOutlet weak var nameTextField: UITextField!
//  @IBOutlet weak var lastNameTextField: UITextField!
//  @IBOutlet weak var emailTextField: UITextField!
//  @IBOutlet weak var checkInDateLabel: UILabel!
//  @IBOutlet weak var checkInDatePicker: UIDatePicker!
//  @IBOutlet weak var checkOutDateLabel: UILabel!
//  @IBOutlet weak var checkOutDatePicker: UIDatePicker!
//  let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
//  let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
//  let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
//  let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
//  var dateFormatter: DateFormatter = {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateStyle = .medium
//    return dateFormatter
//  }()
//  var isCheckInDatePickerVisible: Bool = false {
//    didSet {
//      checkInDatePicker.isHidden = !isCheckInDatePickerVisible
//    }
//  }
//  var isCheckOutDatePickerVisible: Bool = false {
//    didSet {
//      checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
//    }
//  }
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    let midnightToday = Calendar.current.startOfDay(for: Date())
//    checkInDatePicker.minimumDate = midnightToday
//    checkInDatePicker.minimumDate = midnightToday
//    updateDateViews()
//    // Uncomment the following line to preserve selection between presentations
//    // self.clearsSelectionOnViewWillAppear = false
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem
//  }
//  // MARK: - Table view data source
//  func updateDateViews() {
//    checkOutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkInDatePicker.date)
//    checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
//    checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
//  }
//  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    switch indexPath {
//      case checkInDatePickerCellIndexPath where
//        isCheckInDatePickerVisible == false:
//        return 0
//      case checkOutDatePickerCellIndexPath where
//        isCheckOutDatePickerVisible == false:
//        return 0
//      default:
//        return UITableView.automaticDimension
//      }
//  }
//  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    if indexPath == checkInDateLabelCellIndexPath &&
//        isCheckOutDatePickerVisible == false {
//        // check-in label selected, check-out picker is not visible, toggle check-in picker
//        isCheckInDatePickerVisible.toggle()
//      } else if indexPath == checkOutDateLabelCellIndexPath &&
//        isCheckInDatePickerVisible == false {
//        // check-out label selected, check-in picker is not visible, toggle check-out picker
//        isCheckOutDatePickerVisible.toggle()
//      } else if indexPath == checkInDateLabelCellIndexPath ||
//        indexPath == checkOutDateLabelCellIndexPath {
//        // either label was selected, previous conditions failed meaning at least one picker is visible, toggle both
//        isCheckInDatePickerVisible.toggle()
//        isCheckOutDatePickerVisible.toggle()
//      } else {
//        return
//      }
//      tableView.beginUpdates()
//      tableView.endUpdates()
//    }
//  @IBAction func checkInDateValueChanged(_ sender: Any) {
//    updateDateViews()
//  }
//  @IBAction func checkOutDateValueChanged(_ sender: Any) {
//    updateDateViews()
//  }
//  @IBAction func doneBarButtonTapped(_ sender: Any) {
//    let firstName = nameTextField.text ?? “”
//    let lastName = lastNameTextField.text ?? “”
//    let email = emailTextField.text ?? “”
//    print(firstName)
//    print(lastName)
//    print(email)
//  }
//}
//
//
//Message Reece Olsen
//
//
//
//
//
//
//
