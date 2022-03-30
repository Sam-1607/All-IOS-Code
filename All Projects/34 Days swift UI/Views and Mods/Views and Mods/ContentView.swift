//
//  ContentView.swift
//  Views and Mods
//
//  Created by Sam Hiatt  on 12/27/21.
//

import SwiftUI
struct Watermarked: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.teal)
                .padding(20)
                .background(.brown)
        }
    }
}

extension View {
    func waterMarked(with text: String) -> some View {
        modifier(Watermarked(text: text))
    }
}


struct Title: ViewModifier {
    
    
    func body(content: Content) -> some View {
        content
        
            .font(.largeTitle)
            .foregroundColor(.red)
            .padding()
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 50))
    }
}

extension View {
    func styleForText() -> some View {
        modifier(Title())
        
    }
}

struct ContentView: View {
    var body: some View {
        
    
        Color.blue
            .frame(width: 300, height: 300)
            .waterMarked(with: "Heeeeeey")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
