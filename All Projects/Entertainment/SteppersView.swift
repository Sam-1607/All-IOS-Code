//
//  SteppersView.swift
//  Entertainment
//
//  Created by Sam Hiatt  on 3/26/22.
//

import SwiftUI

struct SteppersView: View {
    
    @State private var selectedNumber =  Int.random(in: 1...10)
    @State private var amountOfQuestions = 0
    @State private var maxMultipliableNumber = 0
    @State private var minimumMultipliableNumber = 0
    @State private var correctAnswer = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                Stepper("Max Number to Multiply to: \(maxMultipliableNumber)") {
                    if maxMultipliableNumber < 12 {
                        self.maxMultipliableNumber += 1
                    }
                } onDecrement: {
                    if maxMultipliableNumber > 0 {
                        self.maxMultipliableNumber -= 1
                    }
                }
                .padding()
                .background(.pink)
                .cornerRadius(25)
                .padding(.top, 50)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Stepper("Minumum Number to Multiply to: \(minimumMultipliableNumber)") {
                    if minimumMultipliableNumber < 12 {
                        self.minimumMultipliableNumber += 1
                    }
                } onDecrement: {
                    if minimumMultipliableNumber > 0 {
                        self.minimumMultipliableNumber -= 1
                    }
                }
                .padding()
                .background(.blue)
                .cornerRadius(25)
                .padding(.top, 50)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            
                
                Stepper("How Many Questions: \(amountOfQuestions)") {
                    amountOfQuestions += 1
                } onDecrement: {
                    if amountOfQuestions > 0 {
                        amountOfQuestions -= 1
                    }
                }
                .padding()
                .background(.yellow)
                .cornerRadius(25)
                .padding(.top, 50)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                
                
                NavigationLink("Start Game") {
                    StartGameView()
                }
                
                .padding()
                .background(.black)
                .cornerRadius(20)
                .padding(.top, 50)
            } .navigationTitle("Select your Difficulties")
        }
    }
}

struct SteppersView_Previews: PreviewProvider {
    static var previews: some View {
        SteppersView()
    }
}
