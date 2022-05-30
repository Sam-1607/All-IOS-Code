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
        fetchData()
        setTeam(team: team)
    }
    
    func setTeam(team: TeamStats?) {
        if let team = team {
                DispatchQueue.main.async {
                    self.leagueImageView.sd_setImage(with: URL(string: team.country.flag))
                    self.flagImageView.sd_setImage(with: URL(string: team.league.logo))
                    self.teamLogoImageView.sd_setImage(with: URL(string: team.team.logo))
                    
                    self.leagueImageView.layer.borderColor = UIColor.white.cgColor
                    self.flagImageView.layer.borderColor = UIColor.white.cgColor
                    self.teamLogoImageView.layer.borderColor = UIColor.white.cgColor
                    
                    self.leagueImageView.layer.borderWidth = 3
                    self.flagImageView.layer.borderWidth = 3
                    self.teamLogoImageView.layer.borderWidth = 3
                    
                    self.leagueImageView.layer.cornerRadius = 25
                    self.flagImageView.layer.cornerRadius = 25
                    self.teamLogoImageView.layer.cornerRadius = 25
                }
                
                self.leagueNameLabel.text = team.league.name
                self.countryNameLabel.text = team.country.name
                self.teamNameLabel.text = team.team.name
                
                self.teamNameTitleLabel.text = team.team.name
                self.gamesTitleLabel.text = "Games Details"
                self.pointsTitleLabel.text = "Points Details"
            }
            
            
    }
    
    
    func fetchData() {
        teamNetworkController.fetchTeam { result in
            switch result {
            case .success(let team):
                self.team = team
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
