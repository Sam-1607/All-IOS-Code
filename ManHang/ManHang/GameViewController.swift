//
//  ViewController.swift
//  ManHang
//
//  Created by Sam Hiatt  on 7/15/22.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var disPlayWordLabel: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    @IBOutlet weak var wrongLetters: UILabel!
    
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var hangManImage: UIImageView!
    
    
    var wordsArray = ["SIMPING", "HIGH", "LOADED", "MONEY"]
    var wrongLettersArray = [Character]()
    var usedLetters = [Character]()
    var displayWordArray = [Character]()
    
    var word = ""
    var displayWord = ""
    var guess: Character!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        word = wordsArray.randomElement()!.lowercased()
        usedLetters = Array(word)
        
        displayWord = String(repeating: "_", count: word.count)
        disPlayWordLabel.text = displayWord
        displayWordArray = Array(displayWord)
    }
    
    @IBAction func guessButton(_ sender: Any) {
        guessTextField.resignFirstResponder()
        
        let guess1 = guessTextField.text
        
        if guess1 == "" {
            guessTextField.placeholder = "Enter a Letter"
        } else if guess1!.count > 1 {
            
        } else {
            guess = Character(guessTextField.text!.lowercased())
            
            checkString()
            displayWord = String(displayWordArray)
            disPlayWordLabel.text = displayWord
            guessTextField.text = ""
            checkIfWon()
        }
        
    }
    
    @IBAction func restartButton(_ sender: Any) {
        
        guessTextField.text = ""
        hangManImage.image = UIImage(contentsOfFile: "")
        gameImage.image = UIImage(contentsOfFile: "")
        wrongLettersArray = []
        wrongLetters.text = ""
        displayWord = ""
        
        word = wordsArray.randomElement()!.lowercased()
        usedLetters = Array(word)
        displayWord = String(repeating: "_", count: word.count)
        disPlayWordLabel.text = displayWord
        displayWordArray = Array(displayWord)
    }
    
  func checkString() {
        
      if usedLetters.contains(guess) {
          for i in 0...word.count - 1 {
              if guess == usedLetters[i] {
                  displayWordArray[i] = guess
              }
          }
      } else {
          wrongLettersArray.append(guess)
          wrongLetters.text = String(wrongLettersArray)
          updateImage()
      }
      
    }
    
    func updateImage() {
        let p1 = UIImage(named: "pic1")
        let p2 = UIImage(named: "pic2")
        let p3 = UIImage(named: "pic3")
        let p4 = UIImage(named: "pic4")
        let p5 = UIImage(named: "pic5")
        let p6 = UIImage(named: "pic6")
        let p7 = UIImage(named: "pic7")
        let p8 = UIImage(named: "pic8")
        
        let imageArray = [p1,p2,p3,p4,p5,p6,p7,p8]

        hangManImage.image = imageArray[wrongLettersArray.count - 1]
        
    }
    
    func checkIfWon() {
        if wrongLettersArray.count == 8 {
            
            gameImage.image = UIImage(named: "gameOver")
            
        } else if displayWord.contains("_") {
            
        } else {
            gameImage.image = UIImage(named: "youWin")
        }
    }
    

}

