//
//  GameView.swift
//  Entertainment
//
//  Created by Sam Hiatt  on 3/26/22.
//

import SwiftUI

struct GameView: View {
    
    
    @State var number2 = 0
    @State var number1 = 0
    @State var correctAnswer = 0
    @State var stepperView = SteppersView()
    @State private var playerScore = 0
    @Binding var userAnswer: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text("What is \(number1) X \(number2)")
                .font(.largeTitle.bold())
            
            TextField("Enter Answer Here", text: $userAnswer)
                .padding(.leading, 30)
        }
        .onAppear {
            setGameDifficulty()
        }
    }
    
    func setGameDifficulty()  {
        let numbersArray = Array(stepperView.minimumMultipliableNumber...stepperView.maxMultipliableNumber)
        print(numbersArray)
        let question1 = numbersArray[0]
        let question2 = numbersArray[1]
        number1 = question1
        number2 = question2
        correctAnswer = question1 * question2
    }
    
    func checkAnswer() {
        if let userAnswer = Int(userAnswer) {
            if userAnswer == correctAnswer {
                playerScore += 1
                playSound(sound: "correct", type: "mp3")
            } else if playerScore > 0 {
                playerScore -= 1
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    @State static var answer = ""
    static var previews: some View {
        GameView(userAnswer: $answer)
    }
}
