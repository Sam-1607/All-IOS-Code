//
//  TeamViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/28/22.
//

import UIKit

class TeamViewController: UIViewController {
    
    @IBOutlet weak var leagueImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    
    @IBOutlet weak var teamNameTitleLabel: UILabel!
    @IBOutlet weak var gamesTitleLabel: UILabel!
    @IBOutlet weak var gameDetailLabel: UILabel!
    @IBOutlet weak var pointsTitleLabel: UILabel!
    @IBOutlet weak var pointsDetailLabel: UILabel!
    
    var teamNetworkController = AllTeamsNetworkController()
    var team: TeamStats?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func fetchData() {
        teamNetworkController.fetchTeam { result in
            switch result {
            case .success(let team):
                self.team = team
//                DispatchQueue.main.async {
//                    self.view.reloadInputViews()
//                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setTeam(team: TeamStats) {
        
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
