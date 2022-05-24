//
//  ContentView.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by Sam Hiatt  on 12/10/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
