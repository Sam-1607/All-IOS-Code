//
//  RegistrationTableViewController.swift
//  Hotel Something
//
//  Created by Sam Hiatt  on 10/28/21.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    
    @IBOutlet weak var checkinDatePicker: UIDatePicker!
    
    @IBOutlet weak var chekoutDateLabel: UILabel!
    
    @IBOutlet weak var checkoutDatePicker: UIDatePicker!
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    let checkInDateLabelCellIndexPath = IndexPath(row: 1, section: 3)
    let checkOutDateLabelCellIndexPath = IndexPath(row: 1, section: 3)
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            checkinDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    var isCheckOutDatePickerVisible: Bool = false {
        didSet {
            checkoutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkinDatePicker.minimumDate = midnightToday
        checkinDatePicker.date = midnightToday
       
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func update() {
        checkoutDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: 1, to: checkinDatePicker.date)
        
        checkInDateLabel.text = dateFormatter.string(from:
        checkinDatePicker.date)
        chekoutDateLabel.text = dateFormatter.string(from:
        checkinDatePicker.date)
        
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
            let firstName = nameField.text ?? ""
            let lastName = lastNameField.text ?? ""
            let email = emailField.text ?? ""
        let checkInDate = checkinDatePicker.date
        let checkOutDate = checkoutDatePicker.date
        print("DONE TAPPED")
        print("firstName: \(firstName)")
        print("lastName: \(lastName)")
        print("email: \(email)")
        print("checkin: \(checkInDate)")
        print("checkout: \(checkOutDate)")
        

       
    }
    
    
    @IBAction func checkInDateValueChanged(_ sender: Any) {
        update()
    }
    
    @IBAction func checkoutDateValueChanged(_ sender: Any) {
        update()
    }
    
    
    
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
        if indexPath == checkInDatePickerCellIndexPath &&
               isCheckOutDatePickerVisible == false {
                
                isCheckInDatePickerVisible.toggle()
            } else if indexPath == checkOutDatePickerCellIndexPath &&
               isCheckInDatePickerVisible == false {
                
                isCheckOutDatePickerVisible.toggle()
            } else if indexPath == checkInDatePickerCellIndexPath ||
               indexPath == checkOutDatePickerCellIndexPath {
                
                isCheckInDatePickerVisible.toggle()
                isCheckOutDatePickerVisible.toggle()
            } else {
                return
            }
tableView.reloadData()
}
    
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
