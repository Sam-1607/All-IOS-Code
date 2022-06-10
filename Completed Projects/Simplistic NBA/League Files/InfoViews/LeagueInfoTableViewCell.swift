//
//  LeagueInfoTableViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/13/22.
//

import UIKit

class LeagueInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seasonYear: UILabel!
    @IBOutlet weak var seasonStart: UILabel!
    @IBOutlet weak var seasonEnd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
