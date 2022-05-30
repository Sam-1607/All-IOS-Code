//
//  LeagueSeasonCollectionViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/26/22.
//

import UIKit
import AVKit
import AVFoundation

private let reuseIdentifier = "SeasonCell"

class LeagueSeasonCollectionViewController: UICollectionViewController {
    
    let playerController = AVPlayerViewController()
    var player: AVPlayer?
    
    var league: League?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .black
        // loadVideo(resource: "seasonAnimation", fileType: "mp4")
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return league!.seasons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LeagueSeasonCollectionViewCell else { return UICollectionViewCell() }
        let season = league!.seasons[indexPath.row]
        cell.setSeason(season: season)
        cell.backgroundColor = .black
        cell.seasonLabel.textColor = .white
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let allTeamsView = storyboard?.instantiateViewController(withIdentifier: "AllTeamsCollectionView") {
            self.navigationController?.pushViewController(allTeamsView, animated: true)
            let seasons = league?.seasons[indexPath.row]
            let filteredSeason = "\(String(describing: seasons?.season))".filter("0123456789-".contains)
            if let intSeason =  Int(filteredSeason) {
                let filteredSeason2 = intSeason + 1
                seasonParam = "&season=\(filteredSeason)-\(filteredSeason2)"
            }
            seasonParam = "&season=\(filteredSeason)"
            print("seasonTest")
            
        }
    }
    
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
