//
//  CardGameView.swift
//  Card Project Example
//
//  Created by Sam Hiatt  on 1/10/22.
//

import SwiftUI

struct StyleForCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 125)
            .background(.red)
            .cornerRadius(30)
            
        
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(StyleForCard())
    }
}

struct CardGameView: View {
    
    @State private var pictureImage = "?"
    @State private var trueOrFalse = true
    @State private var animationAmount = 0.0
    
    func changePiture() {
        if trueOrFalse == true {
            pictureImage = "😂"
            trueOrFalse = false
        } else if trueOrFalse == false {
            pictureImage = "?"
            trueOrFalse = true
            
        }
    }
    
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Timer")
                .font(.largeTitle)
                .padding()
                .background(.red)
                .clipShape(Capsule())
            
            
       
            
            
            HStack {
                
                Button("\(pictureImage)") {
                    withAnimation {
                        animationAmount += 180
                        
                    }
                    changePiture()
                }
                .buttonStyle()
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 0 , z: 0))
                
                Button("2") {
                    
                }
                .buttonStyle()
                
                Button("3") {
                    
                }
                .buttonStyle()
                
                Button("4") {
                    
                }
                .buttonStyle()
                
            }
            HStack {
                Button("1") {
                    
                }
                .buttonStyle()
                
                Button("2") {
                    
                }
                .buttonStyle()
                
                Button("3") {
                    
                }
                .buttonStyle()
                
                Button("4") {
                    
                }
                .buttonStyle()
            }
            HStack {
                Button("1") {
                    
                }
                .buttonStyle()
                
                Button("2") {
                    
                }
                .buttonStyle()
                
                Button("3") {
                    
                }
                .buttonStyle()
                
                Button("4") {
                    
                }
                .buttonStyle()
            }
            HStack {
                Button("1") {
                    
                }
                .buttonStyle()
                
                Button("2") {
                    
                }
                .buttonStyle()
                
                Button("3") {
                    
                }
                .buttonStyle()
                
                Button("4") {
                    
                }
                .buttonStyle()
            }
            HStack {
                Button("1") {
                    
                }
                .buttonStyle()
                
                Button("2") {
                    
                }
                .buttonStyle()
                
                Button("3") {
                    
                }
                .buttonStyle()
                
                Button("4") {
                    
                }
                .buttonStyle()
            }
            
            
            Text("Score: 10")
                .font(.system(.largeTitle, design: .rounded))
                .padding()
                .background(.red)
                .clipShape(Capsule())
                .padding(.top, 5)
                .padding(.bottom, 30)
        }
    }
}

struct CardGameView_Previews: PreviewProvider {
    static var previews: some View {
        CardGameView()
    }
}

