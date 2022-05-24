//
//  PlayerTableViewCell.swift
//  ScoreBoard
//
//  Created by Sam Hiatt  on 10/19/21.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    var delegate: playerViewDelegate?
    var somePlayer: Player?
    
    
    
    
    @IBAction func stepperTapped(_ sender: UIStepper) {
        currentScoreTitle.text = Int(sender.value).description
        somePlayer?.currentScore = sender.value
        delegate?.updateScore()
        
        }
    
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var playerNameTitle: UILabel!
    
    @IBOutlet weak var currentScoreTitle: UILabel!
    
    func update(with player: Player) {
        playerNameTitle.text = player.playerName
        stepper.value = player.currentScore
        let someStepper = Int(stepper.value)
        currentScoreTitle.text = "\(someStepper)"
        somePlayer = player
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
