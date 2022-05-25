//
//  LeagueInfoViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/11/22.
//

import UIKit
import SwiftUI

class LeagueInfoViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var leagueInfoImageView: UIImageView!
    @IBOutlet weak var seasonInfoTableView: UITableView!
    
    
    var league: League?

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        guard let league = league else {
        //            return 0
        //        }
        return league!.seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "seasonCell", for: indexPath) as? LeagueInfoTableViewCell else { return UITableViewCell() }
        if let league = league {
            for season in league.seasons {
                let seasonYearText = "\(season.season)"
                let result = seasonYearText.filter("0123456789-.".contains)
                cell.seasonYear.text = "Season \(result)"
                cell.seasonStart.text = "Start: \(season.start)"
                cell.seasonEnd.text = "End: \(season.end)"
                cell.layer.borderColor = UIColor.white.cgColor
                cell.layer.cornerRadius = 10
                cell.layer.borderWidth = 3
                
               
               
            }
        }
        tableView.backgroundColor = .black
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = .black
        setLogo()
        
    }
    
    func setLogo() {
        
        
        if let league = league {
            let url = URL(string: league.logo)!
            DispatchQueue.main.async {
                let imageData = try? Data(contentsOf: url)
                self.leagueInfoImageView.image = UIImage(data: imageData!)
                self.leagueInfoImageView.layer.cornerRadius = 17
                self.leagueInfoImageView.layer.borderColor = UIColor.white.cgColor
                self.leagueInfoImageView.layer.borderWidth = 3
            }
            
        }
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
