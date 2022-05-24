//
//  PlayersTableViewController.swift
//  ScoreBoard
//
//  Created by Sam Hiatt  on 10/19/21.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    var playersArray: [Player] = [] {
        didSet {
            Player.saveToFile(playerArray: playersArray)
        }

    }
    
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        guard let source = segue.source as? PlayerForm,
            let player = source.player else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow {
            playersArray.remove(at: indexPath.row)
            playersArray.insert(player, at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            playersArray.append(player)
        }
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playersArray = Player.loadFromFile()
        playersArray.sort {
            $0.currentScore < $1.currentScore
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playersArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        let player = playersArray[indexPath.row]
        cell.update(with: player)
        cell.delegate = self

        

        return cell
    }
    
    
    
    
    @IBSegueAction func editPlayer(_ coder: NSCoder, sender: Any?) -> PlayerForm? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        
        let player = playersArray[indexPath.row]
        
        return PlayerForm(coder: coder, player: player)
        
    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            playersArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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
extension PlayersTableViewController: playerViewDelegate { func updateScore() {
    playersArray.sort {
        $0.currentScore < $1.currentScore
    }
    
    tableView.reloadData()
    Player.saveToFile(playerArray: playersArray)
    
    
}}
