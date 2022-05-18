//
//  LTSCollectionViewCell.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/16/22.
//

import UIKit

class LTSCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionViewImage: UIImageView!
    
    @IBOutlet weak var collectionViewLabel: UILabel!
    
    func setTeam(teams: TeamCollectionRequireMents) {
        
        if  let displayText = teams.displayText {
            self.collectionViewLabel.text = displayText
        } else {
            self.collectionViewLabel.text = "N/A"
        }
            
        if let imageUrlString = teams.displayImage  {
        collectionViewImage.sd_setImage(with: URL(string: imageUrlString)!)
        }
    }
}
