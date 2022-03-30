
import UIKit

protocol EmployeeDetailTableViewControllerDelegate: AnyObject {
    func employeeDetailTableViewController(_ controller: EmployeeDetailTableViewController, didSave employee: Employee)
}

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeTableViewControllerDelegate {
    

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var employeeTypeLabel: UILabel!
    @IBOutlet var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBAction func eventChanged(_ sender: Any) {
        dobLabel.text = dateFormatter.string(from: dobDatePicker.date)
    }
    
    weak var delegate: EmployeeDetailTableViewControllerDelegate?
    var employee: Employee?
    var employeeType: EmployeeType?
    var isEditingBirthday: Bool = true {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 && isEditingBirthday {
            return 0
        }


        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            isEditingBirthday.toggle()
            dobLabel.textColor = .black
            dobLabel.text = dateFormatter.string(from: dobDatePicker.date )
            
        }
    }
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        updateSaveButtonState()
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    private func updateSaveButtonState() {
        let shouldEnableSaveButton = nameTextField.text?.isEmpty == false && employeeType != nil
        saveBarButtonItem.isEnabled = shouldEnableSaveButton
        
        
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let employeeType = employeeType else {
            return
        
        }
        
        let employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType )
        delegate?.employeeDetailTableViewController(self, didSave: employee)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
    }

    @IBAction func nameTextFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    func employeeTypeTableViewController(_ controller: EmployeeTypeTableViewController, didselect employee: EmployeeType) {
        self.employeeType = employee
        employeeTypeLabel.text = "\(employee)"
        employeeTypeLabel.textColor = .black
        updateSaveButtonState()
    }
    
    
    
    @IBSegueAction func showEmployeeType(_ coder: NSCoder) -> EmployeeTypeTableViewController? {
       
        let viewController = EmployeeTypeTableViewController(coder: coder)
        viewController?.delegate = self
        return viewController
    }

    

}
