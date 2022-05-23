//
//  TeamLeagueCollectionViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/17/22.
//

import UIKit
import AVKit
import AVFoundation


protocol TeamCollectionRequireMents {
    var displayText: String? { get  }
    var displayImage: String? { get }
    var ids: StringOrInt? { get }
    var seasonStuff: [Season]? { get }
}

private let reuseIdentifier = "leagueCollectionItem"

class TeamLeagueCollectionViewController: UICollectionViewController {
    var leagueNetworkCall = LeagueNetworkController()
    var allTeamsNetworkCall = AllTeamsNetworkConroller()
    var level: Level! = .league
    var collectionItems: [TeamCollectionRequireMents] = []
    let playerController = AVPlayerViewController()
    var player: AVPlayer?
 
    static func fromStoryboard(level: Level) -> TeamLeagueCollectionViewController? {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "teamLeagueCollectionView") as? TeamLeagueCollectionViewController
        vc?.level = level
        return vc
    }
    
    enum Level {
        case league
        case season([Season])
        case team
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .black
        fetchData()
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LTSCollectionViewCell else { return UICollectionViewCell() }
        let collectionItem = collectionItems[indexPath.row]
        cell.setTeam(teams: collectionItem)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collectionItem = collectionItems[indexPath.row]
        
        switch level! {
        case .season:
            if let seasonID = collectionItem.ids, case .int(let id) = seasonID {
                let id2 = id + 1
                seasonParam = "&season=\(id)-\(id2))"
            }
        case .league:
            
            if let leagueID = collectionItem.ids, case .int(let id) = leagueID {
                leagueParam = "?league=\(id)"
            }
        case .team:
            if let teamID = collectionItem.ids {
                teamParam = "&team=\(teamID)"
            }
        }
        
        switch level! {
        case .league:
            if let seasonArray = collectionItem.seasonStuff, let vc = TeamLeagueCollectionViewController.fromStoryboard(level: .season(seasonArray)) {
                navigationController?.pushViewController(vc, animated: true)
            }
        case .season:
            if let vc = TeamLeagueCollectionViewController.fromStoryboard(level: .team) {
                navigationController?.pushViewController(vc, animated: true)
                
                
            }
            
        case .team:
            if let detailView = storyboard?.instantiateViewController(withIdentifier: "teamDetailView") as? TeamDetailViewController {
                self.navigationController?.pushViewController(detailView, animated: true)
                
            }
            // go to the detail page (Create Later)
        }
        
    }
    
    //MARK: Fetch Data
    
    func fetchData() {
        switch level! {
        case .league:
            fetchLeagueAndSeason()
        case .season(let seasons):
            self.collectionItems = seasons
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        case .team:
            fetchALlTeams()
        }
    }
    
    func fetchLeagueAndSeason() {
        leagueNetworkCall.fetch { result in
            switch result {
            case .success(let league):
                self.collectionItems = league
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func fetchALlTeams() {
        allTeamsNetworkCall.fetchAllTeams { result in
            switch result {
            case .success(let teams):
                self.collectionItems = teams
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
