//
//  FavoritesCollectionViewController.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/16/22.
//

import UIKit
import AVKit
import AVFoundation



private let reuseIdentifier = "favoritesCollectionViewCell"
var favorites: [Favorite] = []

class FavoritesCollectionViewController: UICollectionViewController {
    
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .black
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FavoriteCollectionViewCell else { return UICollectionViewCell() }
        let team = favorites[indexPath.row]
        cell.setFavoriteTeam(team: team)
    
        return cell
    }
}
