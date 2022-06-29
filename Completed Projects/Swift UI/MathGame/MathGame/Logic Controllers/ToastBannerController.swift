//
//  ToastBannerController.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/23/22.
//

import Foundation
import SwiftUI

struct Toast: ViewModifier {
    @Binding var isShowing: Bool
    let duration: TimeInterval
    
    func body(content: Content) -> some View {
        content
        if isShowing {
            
            ZStack {
                Text("Question Count must be 5 or higher")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
                    .padding()
                    .padding()
                    .padding(.leading)
                    .padding(.trailing)
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(radius: 5)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    withAnimation {
                        isShowing = false
                    }
                }
            }
        }
        
    }
}

extension View {
    func toast(isShowing: Binding<Bool>, duration: TimeInterval = 3) -> some View {
        modifier(Toast(isShowing: isShowing, duration: duration))
    }
}
