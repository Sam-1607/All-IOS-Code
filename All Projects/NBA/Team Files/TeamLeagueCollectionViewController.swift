//
//  TeamLeagueCollectionViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/17/22.
//

import UIKit
import AVKit
import AVFoundation
var currentSelectedSeasons: [Season] = []

protocol TeamCollectionRequireMents {
    
    var displayText: String? { get  }
    var displayImage: String? { get }
    var ids: Int? { get }
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
        case league, season([Season]), team
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .black
        //        self.collectionView!.register(LTSCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
         whichDataToCall()
        
        // loadVideo(resource: "teamLoader", fileType: "mp4")
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch level! {
        case .league:
            return collectionItems.count
        case .season:
            return collectionItems.count
        case .team:
            return  collectionItems.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LTSCollectionViewCell else { return UICollectionViewCell() }
        let collectionItem = collectionItems[indexPath.row]
        switch level! {
        case .league:
            cell.setTeam(teams: collectionItem)
        case .season:
            cell.setTeam(teams: collectionItem)
            
        case .team:
            cell.setTeam(teams: collectionItem)
        }
        // Configure the cell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let collectionItem = collectionItems[indexPath.row]
        
        switch level! {
        case .season:
            if let leagueID = collectionItem.ids, let seasonArray = collectionItem.seasonStuff {
                leagueParam = "?league=\(leagueID)"
                currentSelectedSeasons = seasonArray
                
            }
        case .league:
            if let seasonArray = collectionItem.seasonStuff {
                
                for season in seasonArray {
                    let seasonItem = "\(season.season)"
                    seasonParam = seasonItem.filter("0123456789-.".contains)
                }
               
                
            }
        case .team:
            if let teamID = collectionItem.ids {
                teamParam = "&team=\(teamID)"
            }
        }
        
        //
        switch level! {
        case .league:
            if let seasonArray = collectionItem.seasonStuff, let vc = TeamLeagueCollectionViewController.fromStoryboard(level: .season(seasonArray)) {
                            navigationController?.pushViewController(vc, animated: true)
                            currentSelectedSeasons = seasonArray
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
    
    func whichDataToCall() {
        switch level! {
            
        case .league:
            fectchSeasonAndLeauge()
        case .season(let seasons):
                    self.collectionItems = seasons
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
        case .team:
            fetchALlTeams()
        }
    }
    
    func fectchSeasonAndLeauge() {
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
        allTeamsNetworkCall.fetch2 { result in
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
    
    //MARK: Animation Config
    
    
    func loadVideo(resource: String, fileType: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch { }
        
        let path = Bundle.main.path(forResource: resource, ofType: fileType)
        
        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1
        
        self.view.layer.addSublayer(playerLayer)
        
        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
