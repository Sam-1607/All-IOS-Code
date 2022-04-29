//
//  LeagueCollectionVIewControllerTableViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/13/22.
//

import UIKit
import SDWebImageSVGCoder
import AVKit
import AVFoundation

class LeagueTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var networkController = NetworkController()
    var leagues: [League] = []
    var filteredLeagues: [League]!
    let playerController = AVPlayerViewController()
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredLeagues = leagues
        searchBar.delegate = self
        searchBar(searchBar, textDidChange: searchBar.text!)
        fetchData()
        loadVideo()
    }
    
   
    
    // MARK: Functions
    
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
    
    private func loadVideo() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch { }

        let path = Bundle.main.path(forResource: "launchScreen", ofType:"mp4")

        player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1

        self.view.layer.addSublayer(playerLayer)

        player?.seek(to: CMTime.zero)
        player?.play()
    }
    
    
//    private func playVideo() {
//        guard let path = Bundle.main.path(forResource: "launchScreen", ofType:"mp4") else {
//                debugPrint("video file not found")
//                return
//            }
//            let player = AVPlayer(url: URL(fileURLWithPath: path))
//
//            playerController.player = player
//        playerController.videoGravity = .resizeAspectFill
//
//        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player?.currentItem)
//            present(playerController, animated: true) {
//                player.play()
//            }
//        }
//
//
//    @objc func playerDidFinishPlaying(note: NSNotification) {
//        print("Finished Playing Launchscreen")
//    }
  
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
        cell.setLeague(league: league)
        cell.leageCountry.textColor = .white
        cell.leageName.textColor = .white
        cell.backgroundColor = .black
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


