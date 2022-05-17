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
    
    var displayText: String { get  }
    var displayImage: String? { get }
    var ids: Int? { get }
    
}

private let reuseIdentifier = "leagueCollectionItem"

class TeamLeagueCollectionViewController: UICollectionViewController {
    var leagueTableView = LeagueTableViewController()
    
    var leagueItems: [TeamCollectionRequireMents] = []
    let playerController = AVPlayerViewController()
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        loadVideo(resource: "teamLoader", fileType: "mp4")
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return leagueItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LTSCollectionViewCell else { return UICollectionViewCell() }
        let leagueCollectionItem = leagueItems[indexPath.row]
        cell.setTeam(teams: leagueCollectionItem)
        
    
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueCollectionItem = leagueItems[indexPath.row]
        if let leagueID = leagueCollectionItem.ids {
            leagueParam = "?league=\(leagueID)"
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
