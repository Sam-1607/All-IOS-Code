//
//  ContentView.swift
//  RPS
//
//  Created by Sam Hiatt  on 12/30/21.
//

import SwiftUI

struct StyleForButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(50)
                    .background(.black)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
        
        
    }
}
extension View {
    func buttonStyle() -> some View {
        modifier(StyleForButton())
    }
}

struct ContentView: View {
    
    @State private var tureOrFalse = true
    
    @State private var animationAmount = 0.0
    @State private var paperAnimation = 0.0
    @State private var scissorsAnimation = 0.0
    @State private var timesGuessed = 0
    @State private var points = 0
    @State private var computerPoints = 0
    @State private var userSelection = ""
    @State private var showAlert = false
     
    var computerSelection = Int.random(in: 0...2)
    @State private var possibleChoices = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var winLose = true
    
    @State private var winningLosingTitle = "Win"
    @State private var correctAnswer = ""
     
     
    
    
    
    var body: some View {
        
        VStack {
            
            let computerSelected = possibleChoices[computerSelection]
            Text("\(computerSelected) and \(winningLosingTitle)")
                .padding(.bottom, 50)
            HStack {
                VStack {
                    Text("Your Points")
                    Text("\(points)")
                        
                }
                .padding(.leading, 40)
                
                Spacer()
                
                
                VStack {
                    Text("Computer Points")
                    Text("\(computerPoints)")
                }
                .padding(.trailing, 40)
            }
            .padding(.bottom, 80)
            
            
            VStack(spacing: 80) {
                Button("Rock 🪨") {
                    
                    withAnimation {
                        animationAmount += 360
                    }
                    checkRock()
                    restartGame()
                   
                    
                }
                .buttonStyle()
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 5))
                
                
                Button("Paper 📃") {
                    
                    checkPaper()
                    restartGame()
                    withAnimation {
                        paperAnimation += 360
                    }
                }
                .rotation3DEffect(.degrees(paperAnimation), axis: (x: 0, y: 1, z: 1))
                .buttonStyle()
                
                Button("Scissors ✂") {
                    
                    checkScissors()
                    restartGame()
                    withAnimation {
                        if tureOrFalse {
                            tureOrFalse = false
                        scissorsAnimation += 180
                        } else if tureOrFalse == false {
                            tureOrFalse = true
                            scissorsAnimation -= 180
                        }
                    }
                        
                }
                .buttonStyle()
                .rotation3DEffect(.degrees(scissorsAnimation), axis: (x: 0, y: 1, z: 0))
                .alert("Nice Job your score was \(points)", isPresented: $showAlert) {
                    Button("Next Round", action: restartGame)
                
                
            }
            }
            
        }
        
        
    }
    func checkRock() {
        userSelection = "Rock"
        let computerSelected = possibleChoices[computerSelection]
        if winLose == true && computerSelected == "Rock" {
            correctAnswer = "Paper"
            winningLosingTitle = "Win"
        } else if winLose == true && computerSelected == "Paper" {
            correctAnswer = "Scissors"
            winningLosingTitle = "Win"
        } else if winLose == true && computerSelected == "Scissors" {
            correctAnswer = "Rock"
            winningLosingTitle = "Win"
        } else if winLose == false && computerSelected == "Rock" {
            correctAnswer = "Scissors"
            winningLosingTitle = "Lose"
        } else if winLose == false && computerSelected == "Paper" {
            correctAnswer = "Rock"
            winningLosingTitle = "Lose"
        } else if winLose == false && computerSelected == "Scissors" {
            correctAnswer = "Paper"
            winningLosingTitle = "Lose"
        }
        
        
        if userSelection == correctAnswer {
            points += 1
        } else if computerSelected == correctAnswer {
            computerPoints += 1
        }
        possibleChoices.shuffle()
        winLose.toggle()
        timesGuessed += 1
        
        
}
    func checkPaper() {
        userSelection = "Paper"
        let computerSelected = possibleChoices[computerSelection]
        if winLose == true && computerSelected == "Rock" {
            correctAnswer = "Paper"
            winningLosingTitle = "Win"
        } else if winLose == true && computerSelected == "Paper" {
            correctAnswer = "Scissors"
            winningLosingTitle = "Win"
        } else if winLose == true && computerSelected == "Scissors" {
            correctAnswer = "Rock"
            winningLosingTitle = "Win"
        } else if winLose == false && computerSelected == "Rock" {
            correctAnswer = "Scissors"
            winningLosingTitle = "Lose"
        } else if winLose == false && computerSelected == "Paper" {
            correctAnswer = "Rock"
            winningLosingTitle = "Lose"
        } else if winLose == false && computerSelected == "Scissors" {
            correctAnswer = "Paper"
            winningLosingTitle = "Lose"
        }
        
        
        if userSelection == correctAnswer {
            points += 1
        } else if computerSelected == correctAnswer {
            computerPoints += 1
        } else if userSelection == computerSelected {
            points += 0
            computerPoints += 0
        }
        possibleChoices.shuffle()
        winLose.toggle()
        timesGuessed += 1
        
        
    }
    
    func checkScissors() {
        userSelection = "Scissors"
        let computerSelected = possibleChoices[computerSelection]
        if winLose == true && computerSelected == "Rock" {
            correctAnswer = "Paper"
            winningLosingTitle = "Win"
        } else if winLose == true && computerSelected == "Paper" {
            correctAnswer = "Scissors"
            winningLosingTitle = "Win"
        } else if winLose == true && computerSelected == "Scissors" {
            correctAnswer = "Rock"
            winningLosingTitle = "Win"
        } else if winLose == false && computerSelected == "Rock" {
            correctAnswer = "Scissors"
            winningLosingTitle = "Lose"
        } else if winLose == false && computerSelected == "Paper" {
            correctAnswer = "Rock"
            winningLosingTitle = "Lose"
        } else if winLose == false && computerSelected == "Scissors" {
            correctAnswer = "Paper"
            winningLosingTitle = "Lose"
        }
        
        
        if userSelection == correctAnswer {
            points += 1
        } else if computerSelected == correctAnswer {
            computerPoints += 1
        }
        possibleChoices.shuffle()
        winLose.toggle()
        timesGuessed += 1
        
    }
    func restartGame() {
        if timesGuessed == 10 {
            computerPoints = 0
            points = 0
        }
    }
   

}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
