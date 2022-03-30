//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Sam Hiatt  on 12/31/21.
//

import SwiftUI

@State private var computerChoice = ""


var winLose = Bool.random()
var possibleMoves = ["Rock", "Paper", "Scissors"]

struct ContentView: View {

    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
