//
//  LandmarkSettings.swift
//  landmark
//
//  Created by Sam Hiatt  on 12/13/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct LandmarkSettings: View {
    
    @AppStorage("MapView.zoom")
    
    private var zoom: MapView.Zoom = .medium
    
    var body: some View {
        Form {
            Picker("Map zoon:", selection: $zoom) {
                ForEach(MapView.Zoom.allCases) { level in
                    Text(level.rawValue)
                }
            }
            .pickerStyle(.inline)
        }
        .frame(width: 300)
        .navigationTitle("Landmark Settings")
        .padding(80)
    }
}
struct LandmarkSettings_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkSettings()
    }
}
