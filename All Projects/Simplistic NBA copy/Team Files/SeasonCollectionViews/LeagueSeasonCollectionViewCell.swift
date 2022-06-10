//
//  LeagueSeasonCollectionViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/26/22.
//

import UIKit

class LeagueSeasonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var seasonLabel: UILabel!
    
    func setSeason(season: Season) {
        let filteredSeason = "\(season.season)".filter("0123456789-.".contains)
        self.seasonLabel.text = filteredSeason
        seasonLabel.layer.borderColor = UIColor.white.cgColor
        seasonLabel.layer.cornerRadius = 15
        seasonLabel.layer.borderWidth = 3
    }
}
