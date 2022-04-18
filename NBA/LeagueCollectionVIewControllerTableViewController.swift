//
//  LeagueCollectionVIewControllerTableViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/13/22.
//

import UIKit

class LeagueCollectionVIewControllerTableViewController: UITableViewController {
   
    @IBOutlet weak var leagueImageview: UIImageView!
    
    
    var leagues = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> LeagueTableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as? LeagueTableViewCell {
            let league = leagues[indexPath.row]
            cell.leageName.text = league.name
            cell.leageCountry.text = league.country.name
            cell.leagueCountryFlagImage.image = UIImage(contentsOfFile: league.country.flag)
            return cell
        }
        
        return cell
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

    //MARK: Network Call
    
    func fetch() {
        let urlComponents = URLComponents(string: "https://api-basketball.p.rapidapi.com/leagues")
        let decoder = JSONDecoder()
        let task = URLSession.shared.dataTask(with: (urlComponents?.url)!) { data, response, error in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                let decodedLeagues = try decoder.decode(Response.self, from: data)
                    
                    self.leagues = decodedLeagues.results
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
