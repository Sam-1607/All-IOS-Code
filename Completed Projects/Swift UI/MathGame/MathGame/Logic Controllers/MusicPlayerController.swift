//
//  MusicPlayerController.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/23/22.
//

import Foundation
import AVKit

class SoundController {
    func playBackgroundMusic(soundName: String, soundType: String, somePlayer: inout AVAudioPlayer?) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            somePlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = somePlayer else { return }
            
            player.play()
            player.numberOfLoops = .max
            
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    
    func playSoundEffect(soundName: String, soundType: String, somePlayer: inout AVAudioPlayer?) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            somePlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = somePlayer else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
}
