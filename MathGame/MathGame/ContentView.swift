//
//  ContentView.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/21/22.
//

import SwiftUI

var minNum = 2
var maxNum = 12


struct ContentView: View {
    
    @State var selectedMinNum = 2
    @State var selectedMaxNum = 12
    
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
                                    minNum = number
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
                                maxNum = number
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
                        
                    
                    Button {
                        
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
        ContentView()
    }
}
