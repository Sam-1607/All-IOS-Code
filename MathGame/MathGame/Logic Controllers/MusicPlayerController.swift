//
//  MusicPlayerController.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/23/22.
//

import Foundation
import AVKit


class SoundPlayer {
    
    var player: AVAudioPlayer?
    var correctPlayer: AVAudioPlayer?
    
    func playMusic(soundName: String, soundType: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }


    func playCorrectSound(soundName: String, soundType: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            correctPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = correctPlayer else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }

}

