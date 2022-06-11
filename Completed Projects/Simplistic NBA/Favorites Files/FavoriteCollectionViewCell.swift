//
//  FavoriteCollectionViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 6/10/22.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    func setFavoriteTeam(team: Favorite) {
        let imageURl = URL(string: team.imageURl)
        self.teamImageView.sd_setImage(with: imageURl)
        self.teamNameLabel.text = team.teamName
        
    }
}
