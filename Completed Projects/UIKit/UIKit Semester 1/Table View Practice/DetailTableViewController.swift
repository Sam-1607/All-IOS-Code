//
//  DetailTableViewController.swift
//  Table View Practice
//
//  Created by Sam Hiatt  on 10/12/21.
//

import UIKit

protocol DetailViewControllerDelegate {
    func didCreatNewPetName(_:PetName)
    func didEditPetName(_: PetName)
}

class DetailTableViewController: UIViewController {
    var delegate: DetailViewControllerDelegate?
    var petName: PetName?
    @IBOutlet weak var nameTextField: UITextField!
    
    
    
    @IBOutlet weak var animalTextField: UITextField!
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let animal = animalTextField.text  else {return}
        
        if let oldPetName = petName {
            let editedPetName = PetName(id: oldPetName.id, name: name, animal: animal)
            delegate?.didEditPetName(editedPetName)
        }
        
        
        let newPetName = PetName(id: UUID(), name: name, animal: animal)
        delegate?.didCreatNewPetName(newPetName)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

title = "Add New Pet Name"
        nameTextField.text = petName?.name
        animalTextField.text = petName?.animal
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
