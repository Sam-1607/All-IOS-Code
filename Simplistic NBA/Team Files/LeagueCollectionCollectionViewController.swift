//
//  LeagueCollectionCollectionViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/26/22.
//

import UIKit

private let reuseIdentifier = "firstLeagueCollectionViewCell"

class LeagueCollectionCollectionViewController: UICollectionViewController {
    
    
    var leagueNetworkCall = LeagueNetworkController()
    var leagueItems: [League] = []
    
    override func viewDidLoad() {
        self.collectionView.backgroundColor = .black
        super.viewDidLoad()
        fetchLeagues()
        
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> LeagueCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LeagueCollectionViewCell else { return LeagueCollectionViewCell() }
        let league = leagueItems[indexPath.row]
        cell.setLeague(league: league)
        cell.backgroundColor = .black
        
        return cell
    }
    
    //MARK: Date Source Call
    
    func fetchLeagues() {
        leagueNetworkCall.fetch { result in
            switch result {
            case .success(let leagues):
                self.leagueItems = leagues
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let seasonView = storyboard?.instantiateViewController(withIdentifier: "LeagueSeasonView") as? LeagueSeasonCollectionViewController {
        let league = leagueItems[indexPath.row]
            
            self.navigationController?.pushViewController(seasonView, animated: true)
            seasonView.league = league
            
        }
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
