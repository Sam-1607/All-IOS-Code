//
//  ContentView.swift
//  Entertainment
//
//  Created by Sam Hiatt  on 1/3/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedNumber =  Int.random(in: 1...10)
    @State private var amountOfQuestions = 0
    @State private var answer = ""
    
    
    var numbers1 = [2,3,4,5,6,7,8,9,10,11,12]
    var numbers2 = [2,3,4,5,6,7,8,9,10,11,12]
    
    
    var body: some View {
        List {
        Text("What times what = this")
                .padding(.leading, 80)
                .padding()
            Section {
        TextField("Enter your anser", text: $answer)
            }
                
    }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
