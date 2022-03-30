//
//  ContentView.swift
//  GuessTheFlagg
//
//  Created by Sam Hiatt  on 12/22/21.
//

import SwiftUI

struct largeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueTitle() -> some View {
        modifier(largeBlueTitle())
    }
}

// this is my Custom modifier that I created but I am not using it for anything. 

struct ContentView: View {
    
    @State private var animationAmount = 1.0
    
    @State private var finalScores = 0
    
    @State private var rounds = 0
    
    @State private var scoreKeeper = 0
    
    @State private var selectedFlag = ""
    
    @State private var numberOfCorrect = 0
    @State private var numberOfIncorrect = 0
    
    @State private var moreColors1: [Color] = [.gray, .yellow, .pink, .red, .blue, .white].shuffled()
    
    @State private var moreColors2: [Color] = [.green, .black, .brown, .orange, .indigo, .cyan].shuffled()
    
    // @State private var selector = Int.random(in: 0...4)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    
    
    var FlagImage: some View {
       
       ForEach(0..<3) { number in
           Button {
               
               withAnimation {
                   animationAmount += 360
               }
               
               setFinalScore()
               flagTapped(number)
               
           } label: {
               Image(countries[number]) // Here is the line you are looking for
                   .renderingMode(.original)
                   .clipShape(Capsule())
                   .shadow(radius: 5)
                   
           
           }
           
       }
       .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 0, z: 5))
    }
    
    var body: some View {
        
        
        
        ZStack {
            RadialGradient(stops: [
                .init(color: moreColors1[0], location: 0.3),
                .init(color: moreColors2[0], location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Text("Rounds: \(rounds)")
                
                Spacer()
                
                Text("Guess the flag noob")
                    .font(.largeTitle.bold())
                    .foregroundColor(moreColors2[0])
                
                HStack {
                    Text("Correct")
                        .padding(.leading, 55)
                        .font(.subheadline.bold())
                        .foregroundColor(moreColors2[0])
                    Spacer()
                    Text("Incorrect")
                        .padding(.trailing, 55)
                        .font(.subheadline.bold())
                        .foregroundColor(moreColors2[0])
                }
                
                HStack {
                    
                    Text("\(numberOfCorrect)")
                        .padding(.leading, 78)
                        .font(.subheadline.bold())
                        .foregroundColor(moreColors2[0])
                    Spacer()
                    Text("\(numberOfIncorrect)")
                        .padding(.trailing, 80)
                        .font(.subheadline.bold())
                        .foregroundColor(moreColors2[0])
                }
                
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.bold))
                        Text(countries[correctAnswer])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    FlagImage
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 90))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreKeeper)")
                    .font(.largeTitle.bold())
                    .foregroundColor(moreColors1[0])
                Spacer()
            }
            .padding(.trailing, 20)
            .padding(.leading, 20)
            
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
            
        } message: {
            if numberOfCorrect + numberOfIncorrect == 8 {
                
                Text("Your final score is \(finalScores)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
            } else {
                
                Text("Your score is \(scoreKeeper)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
            } 
        }
    }
    
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer && numberOfCorrect + numberOfIncorrect < 8 {
            scoreTitle = "Correct"
            numberOfCorrect += 1
            scoreKeeper += 1
            finalScores += 1
        } else if numberOfCorrect + numberOfIncorrect == 8 {
            scoreKeeper = 0
            rounds += 1
            numberOfCorrect = 0
            numberOfIncorrect = 0
            finalScores = 0
            scoreTitle = "Next Round"
        } else {
            scoreTitle = "Wrong that is not the flag of \(countries[correctAnswer])"
            numberOfIncorrect += 1
            if scoreKeeper > 0 {
                scoreKeeper -= 1
                finalScores -= 1
            }
        }
        showingScore = true
        
            
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        moreColors1.shuffle()
        moreColors2.shuffle()
        
            
        
    }
    
    
    func setFinalScore() {
        if numberOfCorrect + numberOfIncorrect == 8 {
            finalScores = (numberOfCorrect - numberOfIncorrect)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
