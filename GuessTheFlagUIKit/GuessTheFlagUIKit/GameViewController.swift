//
//  ViewController.swift
//  GuessTheFlagUIKit
//
//  Created by Sam Hiatt  on 6/2/22.
//

import UIKit
import WebKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var wrongAnswersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var flagImageView: WKWebView!
    
    @IBAction func guessButton1(_ sender: UIButton) {
        let possibleSelections = countries[0...2].shuffled()
        sender.titleLabel?.text = possibleSelections[0]
        gameLogic(correctAnswer: countries[0])
        style()
    }
    
    @IBAction func guessButton2(_ sender: UIButton) {
        let possibleSelections = countries[0...2].shuffled()
        sender.titleLabel?.text = possibleSelections[1]
        gameLogic(correctAnswer: countries[0])
        style()
    }
    
    @IBAction func guessButton3(_ sender: UIButton) {
        let possibleSelections = countries[0...2].shuffled()
        sender.titleLabel?.text = possibleSelections[2]
        gameLogic(correctAnswer: countries[0])
        style()
    }
    
    var score = 0
    var wrongGuess = 0
    var rightGuess = 0
    var userSelection = ""
    
    
    
    var countries: [String] = ["Brazil","Armenia","Austria","Bangladesh","Bermuda","Botswana","Bulgaria","Chile","China","Colombia","Croatia","Cuba","Denmark","Ecuador","Egypt","Ethiopia","Finland","France","Germany","Greece","Haiti","Hungary","Iceland","Ireland","Italy","Japan","Kenya","Latvia","Lebanon","Madagascar","Mexico","Monaco","Nepal","Nicaragua","Nigeria","Norway","Oman","Paraguay","Peru","Rwanda","Samoa","Seychelles","Singapore","Slovakia","Slovenia","Spain","Sweden","Switzerland","Tajikistan","Thailand","Tonga","Turkmenistan","Uganda","Uruguay","Yemen","Zambia","Zimbabwe","Vanuatu","Uzbekistan","Ukraine","Turkmenistan","Tokelau","Somalia","Serbia","Réunion","Qatar","Portugal"].shuffled()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch(urlParameter: countries[0].lowercased())
       
    }
       
    func gameLogic(correctAnswer: String) {
        if userSelection != correctAnswer {
            wrongGuess += 1
            
            if score != 0 {
                score -= 1
            }
        } else {
            score += 1
            rightGuess += 1
        }
    }
    
    func fetch(urlParameter: String) {
        let url = URL(string: "https://countryflagsapi.com/svg/\(urlParameter)")!
        let urlResuest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlResuest) { data, response, error in
            
            if data != nil {
                DispatchQueue.main.async {
                    self.flagImageView.load(urlResuest)
                }
            }
            else if let error = error {
                print(error)
            }
        }
        task.resume()
    }
    
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
            self.wrongAnswersLabel.text = "correct: 0\(wrongGuess)"
        } else  {
            self.wrongAnswersLabel.text = "incorrect: \(wrongGuess)"
        }
        
        if score < 10 {
            self.scoreLabel.text = "0\(score)"
        } else {
            self.scoreLabel.text = "\(score)"
        }
    }
    
//    func fetchImage(completionHandler: @escaping (String) -> Void, urlParam: String) {
//        let url = URL(string: "https://country-flags.p.rapidapi.com/svg/\(urlParam)")!
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
//
//            if data != nil {
//                DispatchQueue.main.async {
//                    self.flagImageView.load(URLRequest(url: url))
//                }
//            }
//
//            if let error = error {
//                print(error)
//            }
//        })
//        task.resume()
//    }
}
    


