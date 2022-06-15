//
//  ViewController.swift
//  GuessTheFlagUIKit
//
//  Created by Sam Hiatt  on 6/2/22.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

var countries: [String] = ["Brazil","Armenia","Austria","Bangladesh","Bermuda","Botswana","Bulgaria","Chile","China","Colombia","Croatia","Cuba","Denmark","Ecuador","Egypt","Ethiopia","Finland","France","Germany","Greece","Haiti","Hungary","Iceland","Ireland","Italy","Japan","Kenya","Latvia","Lebanon","Madagascar","Mexico","Monaco","Nepal","Nicaragua","Nigeria","Norway","Oman","Paraguay","Peru","Rwanda","Samoa","Seychelles","Singapore","Slovakia","Slovenia","Spain","Sweden","Switzerland","Tajikistan","Thailand","Tonga","Turkmenistan","Uganda","Uruguay","Yemen","Zambia","Zimbabwe","Vanuatu","Uzbekistan","Ukraine","Turkmenistan","Tokelau","Somalia","Serbia","Réunion","Qatar","Portugal"].shuffled()

class GameViewController: UIViewController {
    
    var score = 0
    var wrongGuess = 0
    var rightGuess = 0
    var userSelection = ""
    var possibleSelections = countries[0...2].shuffled()
    
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var wrongAnswersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var guessButton1Outlet: UIButton!
    @IBOutlet weak var guessButton2Outlet: UIButton!
    @IBOutlet weak var guessButton3Outlet: UIButton!
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    @IBAction func restartButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func guessButton1(_ sender: UIButton) {
        self.userSelection = possibleSelections[0]
        gameLogic(correctAnswer: countries[0])
    }
    
    @IBAction func guessButton2(_ sender: UIButton) {
        self.userSelection = possibleSelections[1]
        gameLogic(correctAnswer: countries[0])
    }
    
    @IBAction func guessButton3(_ sender: UIButton) {
        self.userSelection = possibleSelections[2]
        gameLogic(correctAnswer: countries[0])
           
}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        fetchImage(urlParam: countries[0].lowercased())
        self.scoreLabel.text = "0\(score)"
        
        self.guessButton1Outlet.titleLabel?.text = possibleSelections[0]
        self.guessButton2Outlet.titleLabel?.text = possibleSelections[1]
        self.guessButton3Outlet.titleLabel?.text = possibleSelections[2]
    }
    
    //MARK: Game Logic and Styling
    
    func gameLogic(correctAnswer: String) {
        if userSelection != correctAnswer {
            wrongGuess += 1
            if score != 0 {
                score -= 1
            }
            let alert = UIAlertController(title: "You Suck!", message: "That is Incorrect! This is the flag of \(correctAnswer)!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Continue", style: .cancel) { (action) in
                self.shuffle()
                self.style()
                self.fetchImage(urlParam: countries[0])
            }
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
            
        } else {
            score += 1
            rightGuess += 1
            let alert = UIAlertController(title: "Great Job ", message: "That is the flag of \(correctAnswer)!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Continue", style: .cancel) { (action)  in
                self.shuffle()
                self.style()
                self.fetchImage(urlParam: countries[0])
            }
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
        
        //MARK: Scoring Logic
        
        if rightGuess < 10 {
            self.correctAnswersLabel.text = "correct: 0\(rightGuess)"
        } else {
            self.correctAnswersLabel.text = "incorrect: \(rightGuess)"
        }
        
        if wrongGuess < 10 {
            self.wrongAnswersLabel.text = "incorrect: 0\(wrongGuess)"
        } else  {
            self.wrongAnswersLabel.text = "incorrect: \(wrongGuess)"
        }
        
        if score < 10 {
            self.scoreLabel.text = "0\(score)"
        } else {
            self.scoreLabel.text = "\(score)"
        }
    }
    
    func shuffle() {
        countries.shuffle()
        self.possibleSelections[0] = countries[0]
        self.possibleSelections[1] = countries[1]
        self.possibleSelections[2] = countries[2]
        possibleSelections.shuffle()
    }
    
    //MARK: API Call
    
    func fetchImage(urlParam: String) {
        let url = URL(string: "https://countryflagsapi.com/png/\(urlParam)")!
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if data == data {
                DispatchQueue.main.async {
                    self.flagImageView.sd_setImage(with: url)
                }
            } else if let error = error {
                print(error)
            }
        }
        task.resume()
    }
    
    //MARK: Styling
    
    func style() {
        self.flagImageView.layer.borderColor = UIColor.systemBlue.cgColor
        self.flagImageView.layer.borderWidth = 3
        self.flagImageView.layer.cornerRadius = 20
        
        if rightGuess < 10 {
            self.correctAnswersLabel.text = "correct: 0\(rightGuess)"
        } else {
            self.correctAnswersLabel.text = "incorrect: \(rightGuess)"
        }
        
        if wrongGuess < 10 {
            self.wrongAnswersLabel.text = "incorrect: 0\(wrongGuess)"
        } else  {
            self.wrongAnswersLabel.text = "incorrect: \(wrongGuess)"
        }
        
        if score < 10 {
            self.scoreLabel.text = "0\(score)"
        } else {
            self.scoreLabel.text = "\(score)"
        }
        
        self.guessButton1Outlet.titleLabel?.text = possibleSelections[0]
        self.guessButton2Outlet.titleLabel?.text = possibleSelections[1]
        self.guessButton3Outlet.titleLabel?.text = possibleSelections[2]
    }
}



