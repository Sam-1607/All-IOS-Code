//
//  LeagueTableViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/14/22.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leagueCountryFlagImage: UIImageView!
    @IBOutlet weak var leageName: UILabel!
    @IBOutlet weak var leageCountry: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
