//
//  NotificationView.swift
//  WatchLandmarks WatchKit Extension
//
//  Created by Sam Hiatt  on 12/10/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var title: String?
    var message: String?
    var landmark: Landmark?
    
    var body: some View {
        VStack {
            
            if landmark != nil {
                CircleImage(image: landmark!.image.resizable())
                    .scaledToFit()
            }
        Text(title ?? "Unkown Landmark")
                .font(.headline)
            
            Divider()
            
            Text(message ?? "You are within 5 miles of one of your favorite landmarks")
                .font(.caption)
        
        }
        .lineLimit(0)
            
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        NotificationView()
            NotificationView(title: "Turtle Rock", message: "You are within 5 miles of Turtle Rock", landmark: ModelData().landmarks[0])
    }
}
}
