//
//  MorseCodePlayer.swift
//  MorseCodeHaptics
//
//  Created by Sam Hiatt  on 3/22/22.
//

import Foundation

protocol MorseCodePlayer {
    func playMessage(message: MorseCodeMessage) throws
}
