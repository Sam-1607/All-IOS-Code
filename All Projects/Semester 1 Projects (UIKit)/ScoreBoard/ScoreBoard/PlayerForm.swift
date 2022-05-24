//
//  PlayerForm.swift
//  ScoreBoard
//
//  Created by Sam Hiatt  on 10/19/21.
//

import Foundation
import UIKit
class PlayerForm: UIViewController {
    var player: Player?
    @IBOutlet weak var playerNameTextField: UITextField!
    
    
    @IBOutlet weak var currentScoreTextField: UITextField!
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let playerName = playerNameTextField.text,
              let currentScore = currentScoreTextField.text,
              let somePlayerScore = Double(currentScore)
        else {return}
        
        player = Player(playerName: playerName, currentScore: somePlayerScore)
        performSegue(withIdentifier: "SaveUnwind", sender: self)
    }
    
    
    init?(coder: NSCoder, player: Player?) {
        self.player = player
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.player = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
