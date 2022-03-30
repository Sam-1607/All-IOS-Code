//
//  ContentView.swift
//  MacLandmarks
//
//  Created by Sam Hiatt  on 12/13/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
            .frame(minWidth: 700, minHeight: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
