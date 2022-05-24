//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Sam Hiatt  on 11/8/21.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToCellDelegate {
    func checkMarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete.toggle()
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            ToDo.saveTodos(todos)
        }
    }
    
    var todos = [ToDo]()
    
    
    
    // MARK: - IBActions and Outlets
    
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! ToDoDetailTableViewController
        
        if let todo = sourceViewController.todo {
            if let indexOfExistingTodo = todos.firstIndex(of: todo) {
                todos[indexOfExistingTodo] = todo
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingTodo, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: todos.count, section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        ToDo.saveTodos(todos)
    }
    
    
    @IBSegueAction func editToDo(_ coder: NSCoder) -> ToDoDetailTableViewController? {
        guard let cell = send as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return nil}
        tableView.deselectRow(at: indexPath, animated: true)
        let detailController = ToDoDetailTableViewController(coder: coder)
        detailController?.todo = todos[indexPath.row]
        return detailController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let saveToDos = ToDo.loadToDos() {
            todos = saveToDos
        } else {
            todos = ToDo.loadSampleToDocs()
        }
        navigationItem.leftBarButtonItem = editButtonItem
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath) as! ToDoCell
        let todo = todos[indexPath.row]
        cell.titleLabel?.text = todo.title
        cell.delegate = self
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            ToDo.saveTodos(todos)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }


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
}
