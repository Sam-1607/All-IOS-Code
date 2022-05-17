//
//  StepperView.swift
//  Profile
//
//  Created by Sam Hiatt  on 3/16/22.
//

import SwiftUI

struct StepperView: View {
    @State var profileCount = 1
    
    var body: some View {
        VStack {
            Stepper("Profile Count: \(profileCount)", value: $profileCount, in: 1...5000, step: Int.Stride(1))
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .font(.headline)
        }
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
