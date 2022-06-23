//
//  GameView.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/22/22.
//

import SwiftUI

struct GameView: View {
    
    @State var gameInfo: Game
    @State var correctAnser = 0
    @State var userAnswer = ""
    @State var lives = 3
    @State var incorrectAnswered = 0
    @State var heartsFull: [String] = ["heart.fill", "heart.fill","heart.fill"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                   
                    Text("WHAT IS?")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .foregroundColor(.yellow)
                    
                    HStack(spacing: 40) {
                        Text("\(gameInfo.minNum)")
                            .font(.system(size: 45))
                            .fontWeight(.bold)
                            .padding(20)
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                            .foregroundColor(.yellow)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                        Text("X")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                        
                        Text("\(gameInfo.maxNum)")
                            .font(.system(size: 45))
                            .fontWeight(.bold)
                            .padding(20)
                            .foregroundColor(.yellow)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    
                    HStack {
                        ForEach(heartsFull, id: \.self) { heart in
                            Image(systemName: heart)
                                .padding(30)
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                        }
                    }
                    Spacer()
                    ZStack {
                        if userAnswer == "" {
                            Text("Answer Here")
                                .foregroundColor(.yellow)
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .padding()
                                .padding(5)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .opacity(1.9)
                        }
                        TextField("", text: $userAnswer)
                            .frame(width: 260, height: 75, alignment: .center)
                            .background(.blue)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                    }
                    
                    HStack {
                        Button {
                            
                        } label: {
                            VStack {
                                Label("", systemImage: "clear")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 40))
                                    .padding(.leading, 55)
                                    .padding(.trailing, 55)
                                    Text("Quit")
                                    .foregroundColor(.yellow)
                                    .padding(.trailing, 8)
                            }
                            .padding(5)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                        
                        Button {
                            
                        } label: {
                            Label("", systemImage: "checkmark")
                                .foregroundColor(.yellow)
                                .font(.system(size: 40))
                                .padding()
                                .padding(.leading, 45)
                                .padding(.trailing, 45)
                                .background(Color.green)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        }
                    }
                    .padding(.top, 50)
                }
                
                
                
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameInfo: Game(minNum: 2, maxNum: 12, questionCount: "5"))
    }
}
