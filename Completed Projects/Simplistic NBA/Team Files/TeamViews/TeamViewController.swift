//
//  TeamViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/28/22.
//


import UIKit
import AVFoundation

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
    var player: AVAudioPlayer?
    var barButtonSystemItem = UIBarButtonItemAppearance()
    override func viewDidLoad() {
        super.viewDidLoad()
        let favoriteBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: .none, action: #selector(addToFavorites))
        self.navigationItem.rightBarButtonItem = favoriteBarButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.team = nil
    }
    
    
    func fetchAndSet() {
        fetchData()
        if let team = team {
            setTeam(team: team)
        }
    }
    
    //MARK: API CALL
    
    func fetchData() {
        teamNetworkController.fetchTeam { result in
            switch result {
            case .success(let team):
                self.team = team
                DispatchQueue.main.async {
                    self.setTeam(team: self.team!)
                }
                print(String(describing: team))
                
            case .failure(let error):
                print(error)
                // WHAT WILL HAPPEN ON THE INTERFACE IF IT RETURNS NIL?? CREATE THE UI FOR THAT
            }
        }
    }
    
    //MARK: View Controller Styling/Setting Values
    
    func setTeam(team: TeamStats) {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underLineAttributedStringGameTitle = NSAttributedString(string: "Game Details", attributes: underlineAttribute)
        let underlineAttributePointsTitle = NSAttributedString(string: "Points Details", attributes: underlineAttribute)
        
        self.leagueImageView.sd_setImage(with: URL(string: team.league.logo))
        
        if let flag = team.country.flag {
            self.flagImageView.sd_setImage(with: URL(string: flag))
        } else {
            self.flagImageView.image = UIImage(named: "logo")
        }
        
        self.teamLogoImageView.sd_setImage(with: URL(string: team.team.logo))
        
        DispatchQueue.main.async {
            self.leagueImageView.layer.borderColor = UIColor.white.cgColor
            self.flagImageView.layer.borderColor = UIColor.white.cgColor
            self.teamLogoImageView.layer.borderColor = UIColor.white.cgColor
            
            self.leagueImageView.layer.borderWidth = 3
            self.flagImageView.layer.borderWidth = 3
            self.teamLogoImageView.layer.borderWidth = 3
            
            self.leagueImageView.layer.cornerRadius = 25
            self.flagImageView.layer.cornerRadius = 40
            self.teamLogoImageView.layer.cornerRadius = 25
        }
        
        self.leagueNameLabel.text = team.league.name
        self.countryNameLabel.text = team.country.name
        self.teamNameLabel.text = team.team.name
        self.teamNameTitleLabel.text = team.team.name
        
        self.gamesTitleLabel.attributedText = underLineAttributedStringGameTitle
        self.gameDetailLabel.text = "Wins - All: \(team.games.wins.all.total)  Home: \(team.games.wins.home.total)  Away: \(team.games.wins.away.total) \n Losses - All: \(team.games.loses.all.total)  Home: \(team.games.loses.home.total)  Away: \(team.games.loses.away.total) \n Draws - All: \(team.games.draws.all.total)  Home: \(team.games.draws.home.total)  Away: \(team.games.draws.away.total) \n Played - All: \(team.games.played.all)  Home: \(team.games.played.home)  Away: \(team.games.played.away)"
        
        self.pointsTitleLabel.attributedText = underlineAttributePointsTitle
        self.pointsDetailLabel.text = "Scored - All: \(team.points.forPoints.total.all)  Home: \(team.points.forPoints.total.home)  Away: \(team.points.forPoints.total.away) \n Average Scored \(team.points.forPoints.average.all) \n Scored Against - All: \(team.points.against.total.all)  Home: \(team.points.against.total.home)  Away: \(team.points.against.total.away) \n Average Scored Against \(team.points.against.average.all)"
    }
    
    //MARK: Barbutton Item
   @objc func addToFavorites() {
       if let team = team {
           let favorite = Favorite(imageURl: team.team.logo, teamName: team.team.name)
           favorites.append(favorite)
           print("Lets Check it out")

       }
    }
}
