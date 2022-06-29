//
//  GameView.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/22/22.
//

import SwiftUI
import AVFAudio

//var aduioPlayer = SoundPlayer()

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var correctAnser = 0
    @State var userAnswer = ""
    @State var lives = 3
    @State var incorrectAnswered = 0
    @State var heartsFull: [String] = ["heart.fill", "heart.fill","heart.fill"]
    @State var gameInfo: [Int] 
    @State var quitButtonTitleText = "Quit"
    @State var isShowing = false
    @State var answeredAmount = 0
    @State var endAlertIsShowing = false
    @State var quitButtonBackground = Color.red
    @State var quitButtonForeground = Color.yellow
    @State var quitButtonSystemImage = "clear"
    @State var overAchieverAlert = "Are you sure you want to Quit?"
    @State var continueAlertButtonText = "Nevermind"
    @State var lostAlertShowing = false
    @State var hasWon = false
    @State var lostAlertText = "You have run out of lives, feel free to switch the settings and try again"
    @State var lostAlertButtonText = "Go Home 😞"
    @State var player: AVAudioPlayer?
    
    var questionCount: Int
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
                        Text("\(gameInfo[0])")
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
                        
                        Text("\(gameInfo[1])")
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
                            isShowing.toggle()
                        } label: {
                            VStack {
                                Label("", systemImage: quitButtonSystemImage)
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 40))
                                    .padding(.leading, 55)
                                    .padding(.trailing, 55)
                                Text("\(quitButtonTitleText)")
                                    .foregroundColor(quitButtonForeground)
                                    .padding(.trailing, 8)
                            }
                            .padding(5)
                            .background(quitButtonBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .alert(overAchieverAlert, isPresented: $isShowing) {
                                Button(continueAlertButtonText, role: .cancel) {
                                    
                                }
                                .padding()
                                .background(.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                Button("Quit", role: .destructive) {
                                    dismiss()
                                }
                            }
                        }
                        
                        Button {
                           gameLogic()
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
                    .padding(.bottom)
                    .alert("Nice Job You finsihed all \(questionCount) Questions!!", isPresented: $endAlertIsShowing) {
                        Button("Home") {
                            
                        }
                        Button("Contine Playing") {
                            
                        }
                    }
                    .alert(lostAlertText, isPresented: $lostAlertShowing) {
                        Button(lostAlertButtonText) {
                            dismiss()
                        }
                    }
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func gameLogic() {
        self.correctAnser = gameInfo[0] * gameInfo[1]
        
        guard let userAnswer = Int(userAnswer) else { return }
        if userAnswer == correctAnser {
            soundPlayer.playsound(soundName: "correct", soundType: "mp3", somePlayer: &player)
            self.gameInfo.shuffle()
            self.answeredAmount += 1
            self.userAnswer = ""
            if answeredAmount ==  questionCount {
                self.hasWon = true
                self.endAlertIsShowing.toggle()
                self.quitButtonSystemImage = "house.fill"
                self.quitButtonForeground = .white
                self.quitButtonBackground = .blue
                self.quitButtonTitleText = "Home"
                self.continueAlertButtonText = "Keep Playing 🤩"
                self.overAchieverAlert = "Nice Job you sure are an overachiver WOW!!"
            }
            
        } else {
            self.lives -= 1
            soundPlayer.playsound(soundName: "incorrect", soundType: "mp3", somePlayer: &player)
            if lives == 2 {
                self.heartsFull[2] = "heart"
            } else if lives == 1 {
                self.heartsFull[1] = "heart"
            } else if lives == 0 && self.hasWon == false {
                self.heartsFull[0] = "heart"
                self.lostAlertShowing.toggle()
            } else if lives == 0 && self.hasWon == true {
                self.heartsFull[0] = "heart"
                self.lostAlertText = "Nice Job anways, feel free to crank up the settings to give yourself a bit of a challenge 👍"
                self.lostAlertButtonText = "Home"
                self.lostAlertShowing.toggle()
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameInfo: [2,12], questionCount: 5)
    }
}
