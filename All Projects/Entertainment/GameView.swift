//
//  GameView.swift
//  Entertainment
//
//  Created by Sam Hiatt  on 3/26/22.
//

import SwiftUI

struct GameView: View {
    
    var startGameView = StartGameView()
    @Binding var answer: String
    @Static var previewSatisfier = ""
    
    var body: some View {
        Text("Question Goes Here")
        
        TextField("Enter Answer Here", text: $answer)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView( answer: previewSatisfier)
    }
}
