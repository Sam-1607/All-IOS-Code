//
//  LeagueCollectionVIewControllerTableViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/13/22.
//

import UIKit
import WebKit

class LeagueTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var networkController = NetworkController2()
    var leagues: [League] = []
    var filteredLeagues: [League]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        filteredLeagues = leagues
        searchBar.delegate = self
        searchBar(searchBar, textDidChange: searchBar.text!)
        fetchData()
    }
    
    func fetchData() {
        networkController.fetch { result in
            switch result {
            case .success(let league):
                self.leagues = league
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
  
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell", for: indexPath) as? LeagueTableViewCell else {
            return UITableViewCell()
        }
        
        let league = filteredLeagues[indexPath.row]
        
        cell.leageName.text = league.name
        cell.leageCountry.text = league.country.name
        
        guard let flagImageString = league.country.flag else { return cell }
        
        if flagImageString.count == 40 {
            guard let url = URL(string: flagImageString) else { return cell }
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if data != nil {
                    DispatchQueue.main.async {
                        cell.leagueWebFlagImageView.load(URLRequest(url: url))
                        
                    }
                    
                    
                    
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
        
        return cell
    }
    
    // MARK: SearchBar Config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredLeagues = []
        
        if searchText == "" {
            filteredLeagues = leagues
        } else {
            for league in leagues {
                if league.name.lowercased().contains(searchText.lowercased()) || league.country.name.lowercased().contains(searchText.lowercased()) {
                    filteredLeagues.append(league)
                }
            }
        }
        self.tableView.reloadData()
        
    }
}
