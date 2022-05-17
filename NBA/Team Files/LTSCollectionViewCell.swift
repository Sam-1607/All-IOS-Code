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

            self.collectionViewLabel.text = teams.displayText
            
            guard let imageUrlString = teams.displayImage else { return }
            let imageUrl = URL(string: imageUrlString)!
            DispatchQueue.main.async {
                let imageData = try? Data(contentsOf: imageUrl)
                self.collectionViewImage.image = UIImage(data: imageData!)
            }
            
        
    }
}
