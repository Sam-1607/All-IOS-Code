//
//  CardViewSample2.swift
//  Card Project Example
//
//  Created by Sam Hiatt  on 1/11/22.
//

import SwiftUI

struct CardViewSample2: View {
    
    var grid: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var fakeData = ["1", "2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
    
    
    
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: grid) {
                ForEach((fakeData), id: \.self) { button in
                    Text("\(button)")
                    
                }
                .padding(40)
            }
            
            .font(.largeTitle)
        }
    }
}

struct CardViewSample2_Previews: PreviewProvider {
    static var previews: some View {
        CardViewSample2()
    }
}
