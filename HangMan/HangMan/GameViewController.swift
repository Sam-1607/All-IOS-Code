//
//  ViewController.swift
//  HangMan
//
//  Created by Sam Hiatt  on 7/6/22.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var wordToGuessProgressLabel: UILabel!
    @IBOutlet weak var guessedLetterTextField: UITextField!
    
    
    @IBAction func guessSubmitButton(_ sender: UIButton) {
        
    }
    
    var words = ["wrinkled", "water","simping", "whatever", "through", "lemons", "grand", "difficult", "encyclopedia", "cellar"].shuffled()
    lazy var wordToGuess: [Character] = []
    var guessProgress = ""
    var guess: Character!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guessProgress = String(repeating: "_ ", count: wordToGuess.count)
        guessedLetterTextField.placeholder = "Enter A Letter"
        
    }
    
    func guessLogic() {
        
        
        
        if guessedLetterTextField.text == "" {
            guessedLetterTextField.placeholder = "Must Enter Letter"
        } else if guessedLetterTextField.text!.count > 1 {
            guessedLetterTextField.text = ""
            guessedLetterTextField.placeholder = "Only one Letter"
        } else {
            guess = Character(guessedLetterTextField.text!.lowercased())
        }
        
        
        
    }
    
    func checkString() {
        
        if wordToGuess.contains(where: guess) {
            
        }
        
    }
}


extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
