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
    
    var networkController = LeagueNetworkController()
    var leagues: [League] = []
    var filteredLeagues: [League]!
    let playerController = AVPlayerViewController()
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredLeagues = leagues
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.barStyle = .black
        tableView.backgroundColor = .black
        searchBar.delegate = self
        searchBar(searchBar, textDidChange: searchBar.text!)
        fetchData()
        loadVideo(resource: "launchScreen", fileType: "mp4")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadVideo(resource: "launchScreen", fileType: "mp4")
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let popUpView = storyboard?.instantiateViewController(withIdentifier: "PopUpView") as? LeagueInfoViewController {
            self.navigationController?.pushViewController(popUpView, animated: true)
            let league = filteredLeagues[indexPath.row]
            popUpView.league = league
        }
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
    
    //MARK: Video Player Config
    
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

}


