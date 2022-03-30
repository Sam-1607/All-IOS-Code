//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Sam Hiatt  on 11/8/21.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {
// MARK: - IBActions and Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isDatePickerHidden = true
    let dateLabelIndex = IndexPath(row: 0, section: 1)
    let datePickerIndex = IndexPath(row: 1, section: 1)
    let notesIndex = IndexPath(row: 0, section: 2)
    var todo: ToDo?
   
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    func updateSaveButtonState() {
        let shouldenableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldenableSaveButton
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dateFormatter.string(from: date)
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndex where isDatePickerHidden == true:
            return 0
        case notesIndex:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateLabelIndex {
            isDatePickerHidden.toggle()
            dueDateLabel.textColor = .black
            updateDueDateLabel(date: dueDatePickerView.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else {return }
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextField.text
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState()
        updateDueDateLabel(date: dueDatePickerView.date)
        dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextField.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(24*60*60)
            updateDueDateLabel(date: dueDatePickerView.date)
            updateSaveButtonState()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

   
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
