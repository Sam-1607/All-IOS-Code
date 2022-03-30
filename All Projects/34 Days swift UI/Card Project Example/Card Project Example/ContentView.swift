//
//  ContentView.swift
//  Card Project Example
//
//  Created by Sam Hiatt  on 1/7/22.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            ZStack {
                List {
                    NavigationLink("VideoGames", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    
                    NavigationLink("Animals", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    
                    NavigationLink("Sports", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    
                    NavigationLink("Numbers", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    
                    NavigationLink("Movies", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    
                    NavigationLink("Food", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    
                    NavigationLink("States", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    NavigationLink("Countries", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                    
                    
                    NavigationLink("Holidays", destination: {
                        CardGameView()
                    })
                        .padding()
                        .font(.system(size: 25))
                }
                .navigationTitle("Game List")
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink("\(Image(systemName: "star.fill"))", destination: {
                            StatsView()
                        })
                            .frame(width: 50, height: 50)
                            .background(.black)
                            .clipShape(Capsule())
                            .padding()
                            .padding(.trailing, 20)
                    }
                }
                
            }
            
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
