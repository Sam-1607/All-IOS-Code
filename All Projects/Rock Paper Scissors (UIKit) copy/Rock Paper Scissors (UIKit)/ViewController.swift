//
//  ViewController.swift
//  Rock Paper Scissors (UIKit)
//
//  Created by Sam Hiatt  on 3/25/22.
//

import UIKit
import SwiftUI
class ViewController: UIViewController {
    
    var userSelection = ""
    var computerChoice = [1,2,3]
    var correctAnswer = ""
    var alertIsShowing = false
    
    let gameResultsAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Next", style: .default) { action in  }
    
    @IBOutlet var userScoreLabel: UILabel!
    @IBOutlet var computerScoreLabel: UILabel!
    
    @IBAction func rockButtonTapped(_ sender: UIButton) {
        userSelection = "Rock"
        userGuessed()
        showAlert()
    }
    
    
    @IBAction func paperButtonTapped(_ sender: UIButton) {
        userSelection = "Paper"
        userGuessed()
        showAlert()
    }
    
    @IBAction func scissorButtonTapped(_ sender: UIButton) {
        userSelection = "Scissor"
        userGuessed()
        showAlert()
    }
    
    func showAlert() {
        if userSelection == correctAnswer {
            gameResultsAlert.title = "Nice Job you won this round"
            self.present(gameResultsAlert, animated: true, completion: nil)
        } else {
            gameResultsAlert.title = "Uh Oh! Better Luck Next Time"
            self.present(gameResultsAlert, animated: true, completion: nil)
        }
    }
    
    func userGuessed() {
        computerChoice.shuffle()
        print("Computer \(correctAnswer), User \(userSelection)")
        
        if let userScore = userScoreLabel.text, let computerScore = computerScoreLabel.text {
            var userScore = Int(userScore)!
            var computerScore = Int(computerScore)!
            if computerChoice[0] == 1 {
                correctAnswer = "Paper"
                if userSelection == correctAnswer {
                    userScore += 1
                    self.userScoreLabel.text = "\(userScore)"
                } else {
                    computerScore += 1
                    self.computerScoreLabel.text = "\(computerScore)"
                }
            } else if computerChoice[0] == 2 {
                correctAnswer = "Scissor"
                if userSelection == correctAnswer {
                    userScore += 1
                    self.userScoreLabel.text = "\(userScore)"
                } else {
                    computerScore += 1
                    self.computerScoreLabel.text = "\(computerScore)"
                }
            } else if computerChoice[0] == 3 {
                correctAnswer = "Rock"
                if userSelection == correctAnswer {
                    userScore += 1
                    self.userScoreLabel.text = "\(userScore)"
                } else {
                    computerScore += 1
                    self.computerScoreLabel.text = "\(computerScore)"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameResultsAlert.addAction(alertAction)
    }
}

