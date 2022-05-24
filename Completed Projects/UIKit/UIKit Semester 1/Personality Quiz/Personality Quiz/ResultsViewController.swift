//
//  ResultsViewController.swift
//  Personality Quiz
//
//  Created by Sam Hiatt  on 10/18/21.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultAnswerLabel: UILabel!
    
    @IBOutlet weak var resultsAnswerDefinitionLabel: UILabel!
    
    
    var responses: [Answer]
    
    init?(coder: NSCoder, responses: [Answer]) {
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func calculatePersonalityResult() {
      let frequencyOfAnswers = responses.reduce(into: [:]) {
        (counts, answer) in
            counts[answer.type, default: 0] += 1
        }
    
        let mostCommonAnswer = frequencyOfAnswers.sorted { $0.1 >
           $1.1 }.first!.key
        
        resultAnswerLabel.text = "You are \(mostCommonAnswer.self)!"
        resultsAnswerDefinitionLabel.text = mostCommonAnswer.definition

        
    }
    
    
    

    
   

    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResult()
        navigationItem.hidesBackButton = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
