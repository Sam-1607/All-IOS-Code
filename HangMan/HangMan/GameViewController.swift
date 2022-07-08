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
    lazy var correctAnswer = words[0]
    var ungessedCharacter = "_ "
    var guessProgress = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func guessLogic(words: [String], unguessedCharacter: String, correctAnswer: String) {
        var wordToGuess = words[0]
        
        for char in wordToGuess {
            self.guessProgress.append(unguessedCharacter)
            self.wordToGuessProgressLabel.text = guessProgress
            
            guard let userGuess = self.guessedLetterTextField.text else  { return }
            var guess = Character(userGuess)
            
            if guess == char {
                 
            }
        }
    }
}

