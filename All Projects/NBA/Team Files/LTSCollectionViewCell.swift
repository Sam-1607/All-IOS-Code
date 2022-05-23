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
        self.collectionViewLabel.textColor = .white
        if  let displayText = teams.displayText {
            self.collectionViewLabel.text = displayText
        } else {
            self.collectionViewLabel.text = "N/A"
        }
            
        if let imageUrlString = teams.displayImage  {
        collectionViewImage.sd_setImage(with: URL(string: imageUrlString)!)
            self.collectionViewImage.layer.borderColor = UIColor.white.cgColor
            self.collectionViewImage.layer.borderWidth = 3
            self.collectionViewImage.layer.cornerRadius = 15
            
        } else {
            self.collectionViewImage.image = UIImage(named: "logo")
            self.collectionViewImage.layer.borderColor = UIColor.white.cgColor
            self.collectionViewImage.layer.borderWidth = 3
            self.collectionViewImage.layer.cornerRadius = 15
        }
    }
    
//    func setSeasons(seasons: [Season]?) {
//        self.collectionViewLabel.textColor = .white
//        if let seasonArray = seasons {
//            for season in seasonArray {
//                let seasonToFilter = "\(season.season)"
//                self.collectionViewLabel.text = seasonToFilter.filter("0123456789-.".contains)
//                self.collectionViewImage.image = UIImage(named: "seasonLogo")
//                self.collectionViewImage.layer.borderColor = UIColor.white.cgColor
//                self.collectionViewImage.layer.borderWidth = 3
//                self.collectionViewImage.layer.cornerRadius = 15
//            }
//        } else {
//            self.collectionViewLabel.text = "N/A"
//            self.collectionViewImage.image = UIImage(named: "seasonLogo")
//            self.collectionViewImage.layer.borderColor = UIColor.white.cgColor
//            self.collectionViewImage.layer.borderWidth = 3
//            self.collectionViewImage.layer.cornerRadius = 15
//        }
//    }
    
    func setSeason(teams: TeamCollectionRequireMents) {
        self.collectionViewLabel.textColor = .white

        if let seasonArray = teams.seasonStuff {
            for seasonItem in seasonArray {
                let seasonToFilter = "\(seasonItem.season)"
                self.collectionViewLabel.text =  seasonToFilter.filter("0123456789-.".contains)
                self.collectionViewImage.image = UIImage(named: "seasonLogo")
                self.collectionViewImage.layer.borderColor = UIColor.white.cgColor
                self.collectionViewImage.layer.borderWidth = 3
                self.collectionViewImage.layer.cornerRadius = 15
            }

        } else {
            self.collectionViewImage.image = UIImage(named: "logo")
            self.collectionViewImage.layer.borderColor = UIColor.white.cgColor
            self.collectionViewImage.layer.borderWidth = 3
            self.collectionViewImage.layer.cornerRadius = 15


        }



    }
    
    // SWITCH lEVEL FOR SeASON
    
}
