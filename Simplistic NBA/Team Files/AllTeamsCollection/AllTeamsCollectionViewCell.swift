//
//  AllTeamsCollectionViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/27/22.
//

import UIKit

class AllTeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamLogoImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    func setTeam(team: AllTeams) {
        self.teamNameLabel.textColor = .white
        self.teamNameLabel.text = team.name
        self.teamLogoImageView.sd_setImage(with: URL(string: team.logo))
        self.teamLogoImageView.layer.borderWidth = 3
        self.teamLogoImageView.layer.cornerRadius = 25
        self.teamLogoImageView.layer.borderColor = UIColor.white.cgColor
    }
}
