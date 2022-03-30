//
//  ContentView.swift
//  Challenge1
//
//  Created by Sam Hiatt  on 3/2/22.
//

import SwiftUI
import UIKit



struct ContentView: View {
    @State private var names = Group()
    @State private var isShowing = false
    @State private var allNames = User2()
    var array = ["1", "2", "3"]
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        List(allNames.users, id: \.self) {
                            Text($0)
                                .foregroundColor(.black)
                        }
                        
                    }
                }
                
                .navigationTitle("Name List")
                .toolbar {
                    NavigationLink("\(Image(systemName: "plus"))") {
                        AddNameView(name: .constant(""))
                    }
                }
                VStack {
                    Button("Select Random Name") {
                        print(allNames.users)
                    }
                    .padding(.bottom, 40)
                }
            }
            
        }
        
    }
    
    // MARK: Functions
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
