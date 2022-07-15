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
    @IBOutlet weak var incorrectLettersGuessed: UILabel!
    
    
    @IBAction func guessSubmitButton(_ sender: UIButton) {
        
    }
    
    var wordsArray = ["wrinkled", "water","simping", "whatever", "through", "lemons", "grand", "difficult", "encyclopedia", "cellar"].shuffled()
    var incorrectLetters = [Character]()
    var usedLetters = [Character]()
    var displayWordArray = [Character]()
    
    var word = ""
    var displayWord = ""
    var guess: Character!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessedLetterTextField.placeholder = "Enter A Letter"
        word = wordsArray.randomElement()!.lowercased()
        wordToGuessProgressLabel.text =  String(repeating: "_ ", count: word.count)
        displayWordArray = Array(displayWord)
        usedLetters = Array(word)
        
        // CREATE AN ALERT WHEN THE VIEW LOADS LETTING PLAYERS KNOW THEY ONLY HAVE 8 LIVES
        
    }
    
    func guessLogic() {
        
        let guess1 = guessedLetterTextField.text
        
        
        if guess1 == "" {
            guessedLetterTextField.placeholder = "Must Enter Letter"
        } else if guess1!.count > 1 {
            guessedLetterTextField.text = ""
            guessedLetterTextField.placeholder = "Only one Letter"
        } else {
            guess = Character(guessedLetterTextField.text!.lowercased())
            checkString()
            displayWord = String(displayWordArray)
            wordToGuessProgressLabel.text = displayWord
            guessedLetterTextField.text = ""
            guessedLetterTextField.placeholder = "Nice"
            checkIfWon()
        }
        
    }
    
    func checkString() {
        
        if usedLetters.contains(guess) {
            for i in 0...word.count - 1 {
                if guess == usedLetters[i] {
                    displayWordArray[i] = guess
                }
            }
        } else {
            incorrectLetters.append(guess)
            incorrectLettersGuessed.text = String(incorrectLetters)
            guessedLetterTextField.text = ""
            guessedLetterTextField.placeholder = "u suck"
        }
        
    }
    
    func checkIfWon() {
        if incorrectLetters.count == 8 {
            // THEY LOST TRIGGER SOME ALERT
            
        } else if displayWord.contains("_ ") {
            
        } else {
            // THEY WIN TRIGGER SOME ALERT
        }
    }
}


extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
