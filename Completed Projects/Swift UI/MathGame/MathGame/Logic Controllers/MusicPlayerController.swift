//
//  MusicPlayerController.swift
//  MathGame
//
//  Created by Sam Hiatt  on 6/23/22.
//

import Foundation
import AVKit


//class SoundPlayer {
//
//    var player: AVAudioPlayer?
//    var correctPlayer: AVAudioPlayer?
//    var incorrectPlayer: AVAudioPlayer?
//    var wrongCountPlayer: AVAudioPlayer?
//
//    func playMusic(soundName: String, soundType: String) {
//        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let player = player else { return }
//
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//
//    func playCorrectSound(soundName: String, soundType: String) {
//        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            correctPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let player = correctPlayer else { return }
//
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func playIncorrect(soundName: String, soundType: String) {
//        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            incorrectPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let player = incorrectPlayer else { return }
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    func playWrongQuestionCount(soundName: String, soundType: String) {
//        guard let url = Bundle.main.url(forResource: soundName, withExtension: soundType) else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//
//            wrongCountPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
//
//            guard let player = wrongCountPlayer else { return }
//
//            player.play()
//
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//}
//
class SoundController {
    func playBackgroundMusic(soundName: String, soundType: String, somePlayer: inout AVAudioPlayer?) {
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
