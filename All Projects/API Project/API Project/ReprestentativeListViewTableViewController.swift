//
//  ReprestentativeListViewTableViewController.swift
//  API Project
//
//  Created by Sam Hiatt  on 11/29/21.
//

import UIKit

class ReprestentativeListViewTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var items = [Representative]()
    let netWorkController = RepresentativeController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func fetchMatchingItems() {
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        
        if searchTerm.isEmpty {
            let query = [
                "searchTerm": searchTerm,
                "lang": "en_us",
                "limit": "5"
            ]
            netWorkController.fetchItems(matching: query) { result in
                switch result {
                case .success(let items):
                    DispatchQueue.main.async {
                        self.items = items
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
                
            }
        }
    }
    
    func configureCell(cell: RepTableViewCell, forItemAt IndexPath: IndexPath) {
        let item = items[IndexPath.row]
        cell.nameLabel.text = item.name
        cell.partyLabel.text = item.party
        cell.linkLabel.text = item.link
    }
    
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "represent", for: indexPath) as! RepTableViewCell
        configureCell(cell: cell, forItemAt: indexPath)

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
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
extension ReprestentativeListViewTableViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        fetchMatchingItems()
    }
}
