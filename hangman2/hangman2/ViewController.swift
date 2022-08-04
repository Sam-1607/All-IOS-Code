//
//  ViewController.swift
//  hangman2
//
//  Created by Dalton Flanagan on 30/5/2020.
//  Copyright © 2020 Dalton Flanagan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayWordLabel: UILabel!
    @IBOutlet weak var wrongLetters: UILabel!
    @IBOutlet weak var guessTextField: UITextField!
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var hangmanImage: UIImageView!
    
    //These are the words people will try to guess
    var wordArray = ["RHYTHM", "LUNATIC", "JUICE"]
    
    //This is the chossen word from the wordArray
     var word = ""
    
    //This is where I store the incorrect guesses
    var wrongLettersArray = [Character]()
    
    //This is where I store the letters used in the word
    var usedLetters = [Character]()
    
    //This is where I display letters and question marks of the word trying to be guessed
    var displayWordArray = [Character]()
    
    //This is the string I display for the user to guess
    var displayWord = ""
    
    //This is the character that the user guesses
    var guess: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //choose the word and assign to variable word
        
        //set displayWord to the right number of question marks and put into diaplay word label
        
    }

    @IBAction func guessButton(_ sender: UIButton) {
        //Resign first responder textField
        
        //Make sure the user has entered a letter but only one letter
        
        //Call the check for letter function
        
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        //Reset the variables, the labels, the images
        
        //Pick a new random word and display it in the label
        
    }
    
    
}

