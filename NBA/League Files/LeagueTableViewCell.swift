//
//  LeagueTableViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/14/22.
//

import UIKit
import SDWebImageSVGCoder
class LeagueTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var leagueFlagImage: UIImageView!
    @IBOutlet weak var leageName: UILabel!
    @IBOutlet weak var leageCountry: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }
    
    func setLeague(league: League) {
        if let flagImageString = league.country.flag, let url = URL(string: flagImageString) {
            let bitmapSize = CGSize(width: 100, height: 60)
            leagueFlagImage.sd_setImage(with: url, placeholderImage: UIImage(systemName: "flag"), options: [], context: [.imageThumbnailPixelSize : bitmapSize])
        } else {
            leagueFlagImage.image = UIImage(systemName: "flag")
        }
        leageName.text = league.name
        leageCountry.text = league.country.name
    }
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        leagueFlagImage.image = nil
    }
}
