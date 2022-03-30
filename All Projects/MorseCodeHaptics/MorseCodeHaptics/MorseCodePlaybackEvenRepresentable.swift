//
//  MorseCodePlaybackEvenRepresentable.swift
//  MorseCodeHaptics
//
//  Created by Sam Hiatt  on 3/22/22.
//

import Foundation

protocol MorseCodePlaybackEventRepresentable {
    var playBackEvents: [MorseCodePlayBackEvent] { get }
}

extension TimeInterval {
    static let morseCodeUnit: TimeInterval = 0.2
}

extension MorseCodeSignal {
    
}
