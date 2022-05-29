//
//  AllTeamsCollectionViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/27/22.
//

import UIKit

private let reuseIdentifier = "AllTeamsCell"

class AllTeamsCollectionViewController: UICollectionViewController {
    
    var allTeamsNetworkController = AllTeamsNetworkController()
    var teams: [AllTeams] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.collectionView.backgroundColor = .black
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> AllTeamsCollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? AllTeamsCollectionViewCell else { return AllTeamsCollectionViewCell() }
        let team = teams[indexPath.row]
        cell.setTeam(team: team)
        cell.backgroundColor = .black
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let teamView = storyboard?.instantiateViewController(withIdentifier: "TeamView") as? TeamViewController {
        let team = teams[indexPath.row]
        teamParam = "\(team.id)"
            self.navigationController?.pushViewController(teamView, animated: true)
        }
    }
    
    func fetchData() {
        allTeamsNetworkController.fetchAllTeams { result in
            switch result {
            case .success(let allTeams):
                self.teams = allTeams
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
}
