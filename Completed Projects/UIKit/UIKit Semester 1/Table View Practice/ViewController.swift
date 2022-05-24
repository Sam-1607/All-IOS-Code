//
//  ViewController.swift
//  Table View Practice
//
//  Created by Sam Hiatt  on 10/12/21.
//

import UIKit

struct PetName {
    let id: UUID
    let name: String
    let animal: String
   
    

}

class ViewController: UIViewController {

    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var petNames = [PetName( id: UUID(), name: "Gigi", animal: "Dog"), PetName(id: UUID(), name: "Panther", animal: "Dog"), PetName(id: UUID(), name: "Professor", animal: "Cat")]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreatNew",  let vc = segue.destination as? DetailTableViewController  {
            vc.delegate = self
            
        }
        
        if segue.identifier == "toEdit", let vc = segue.destination as? DetailTableViewController, let petName = sender as? PetName {
            vc.delegate = self
            vc.petName = petName
           
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let petName = petNames[indexPath.row]
        performSegue(withIdentifier: "toEdit", sender: petName)
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic Cell", for: indexPath)
        let petName = petNames[indexPath.row]
        cell.detailTextLabel?.text = petName.animal
        cell.textLabel?.text = petName.name
        
return cell
}


}
extension ViewController: DetailViewControllerDelegate {
    func didEditPetName(_ editedPetName: PetName) {
        guard let editedIndex = (petNames.firstIndex {storedPetName in storedPetName.id == editedPetName.id }) else {
            print("Something Went Horribly Wrong")
            return
        }
        petNames.remove(at: editedIndex)
        petNames.insert(editedPetName, at: editedIndex)
            
        
    }
    func didCreatNewPetName(_ newPetName: PetName) {
        petNames.append(newPetName)
    }
}
