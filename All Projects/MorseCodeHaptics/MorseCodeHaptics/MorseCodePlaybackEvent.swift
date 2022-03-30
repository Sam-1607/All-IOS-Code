//
//  MorseCodePlaybackEvent.swift
//  MorseCodeHaptics
//
//  Created by Sam Hiatt  on 3/22/22.
//

import Foundation

enum MorseCodePlayBackEvent {
    case on(TimeInterval)
    case off(TimeInterval)
    
    var duration: TimeInterval {
        switch self {
        case .on(let timeInterval):
            return duration
        case .off(let timeInterval):
            return duration
        }
    }
}

let sosEvents: [MorseCodePlayBackEvent] = [
    // S
    .on(1), .off(1), .on(1), .off(1), .on(1), .off(3),
    // O
    .on(3), .off(1), .on(3), .off(1), .on(3), .off(3),
    // S
    .on(1), .off(1), .on(1), .off(1), .on(1), .off(3)
]
