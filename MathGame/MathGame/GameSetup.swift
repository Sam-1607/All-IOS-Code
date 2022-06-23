//
//  ContentView.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/21/22.
//

import SwiftUI

struct GameSetup: View {
        
    @State var selectedMinNum = 2
    @State var selectedMaxNum = 12
    @State var questionCount = "5"
    @State var countIsInsufficent = false
    @State var textFieldOverlayColor = Color.blue
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(.blue)]
    }
    var minimumMultiplayableNumber = [2,3,4,5]
    var maxMultiplyableNumber = [8,9,10,11,12]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                    .ignoresSafeArea()
                VStack {
                    
                    Image("math2")
                        .resizable()
                    HStack {
                        VStack {
                        Text("Question Count")
                            .font(.system(size: 25))
                           // .padding()
                            .background(.blue)
                           // .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(.yellow)
                        Text("(Must be higher than 5) \n Default is set to 5")
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                                .foregroundColor(.yellow)
                                .multilineTextAlignment(.center)
                        }
                        .padding(10)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        TextField("Enter", text: $questionCount)
                            .frame(width: 150, height: 50, alignment: .center)
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(textFieldOverlayColor, lineWidth: 10)
                            )
                            .foregroundColor(.blue)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .onChange(of: questionCount) { newValue in
                                textFieldOverlayColor = .blue
                            }
                        
                    }
                    .padding()
                    
                    
                    HStack(alignment: .center) {
                        Text("Select a Number")
                            .font(.system(size: 25))
                            .padding()
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(.yellow)
                        Picker("Please Select Range for Question (Lower = Harder)", selection: $selectedMinNum) {
                            ForEach(minimumMultiplayableNumber, id: \.self) { number in
                                Button {
                                    self.selectedMinNum = number
                                } label: {
                                    Text("\(number)")
                                }
                            }
                        }
                     .frame(width: 150, height: 55)
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color.blue, lineWidth: 10)
                        )
        
                        
                    }
                    HStack {
                    Text("Select a Number")
                        .font(.system(size: 25))
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .foregroundColor(.yellow)
                    
                    Picker("Please Select Range for Question (Lower = Harder)", selection: $selectedMaxNum) {
                        ForEach(maxMultiplyableNumber, id: \.self) { number in
                            Button {
                                self.selectedMaxNum = number
                            } label: {
                                Text("\(number)")
                                    .font(.headline)
                            }
                        }
                    }
                 .frame(width: 150, height: 55)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(Color.blue, lineWidth: 10)
                    )
                    }
                    .padding()
                    
                    Text(" Questions will be between \(selectedMinNum) and \(selectedMaxNum)")
                        .font(.system(size: 23))
                        .fontWeight(.bold)
                        .padding()
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .padding(.top)
                        .foregroundColor(.yellow)
                    
                    NavigationLink {
                        GameView(gameInfo: Game(minNum: selectedMinNum, maxNum: selectedMaxNum, questionCount: questionCount))
                    } label: {
                        HStack {
                            Text("Ready")
                                .font(.system(size: 30))
                                .fontWeight(.semibold)
                                .foregroundColor(.yellow)
                            Label("", systemImage: "arrow.forward")
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                        }
                    }
                    .padding()
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 40)
                    .disabled(self.questionCount == "0" || self.questionCount == "1" || self.questionCount == "2" || self.questionCount == "3" || self.questionCount == "4")
                    
                    .onTapGesture {
                        if self.questionCount == "0" || self.questionCount == "1" || self.questionCount == "2" || self.questionCount == "3" || self.questionCount == "4" {
                            self.textFieldOverlayColor = .red
                        }
                    }
                    
                    Spacer()
                    
                   
                }
                .padding(.top, 30)
            }
            .toolbar(content: {
                Button {
                    
                } label: {
                    VStack(alignment: .center) {
                    Label("", systemImage: "gear")
                        .font(.system(size: 29))
                      //  Text("Settings")
                    }
                }
            })
            
            .navigationTitle("Math-Dash")
            
           
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameSetup()
    }
}

