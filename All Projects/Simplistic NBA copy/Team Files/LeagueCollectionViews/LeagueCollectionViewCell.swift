//
//  LeagueCollectionViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/26/22.
//

import UIKit

class LeagueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leagueLogoImageView: UIImageView!
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    func setLeague(league: League) {
        self.leagueNameLabel.text = league.name
        self.leagueNameLabel.textColor = .white
        if let leagueLogo = league.logo {
            self.leagueLogoImageView.sd_setImage(with: URL(string: leagueLogo))
            leagueLogoImageView.layer.borderWidth = 3
            leagueLogoImageView.layer.borderColor = UIColor.white.cgColor
            leagueLogoImageView.layer.cornerRadius = 25
        } else {
            leagueLogoImageView.image = UIImage(named: "logo")
            leagueLogoImageView.layer.borderWidth = 3
            leagueLogoImageView.layer.borderColor = UIColor.white.cgColor
            leagueLogoImageView.layer.cornerRadius = 15
        }
    }
}
