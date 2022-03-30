//
//  Player.swift
//  ScoreBoard
//
//  Created by Sam Hiatt  on 10/19/21.
//

import Foundation

protocol playerViewDelegate {
    func updateScore()
}

class Player: Codable {
    var playerName: String
    var currentScore: Double
    
    
    
    init(playerName: String, currentScore: Double) {
        self.playerName = playerName
        self.currentScore = currentScore
        
    }
    
    
    
    
    
    
    
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var archiveURL = documentsDirectory.appendingPathComponent("players").appendingPathExtension("plist")
    
    static func saveToFile(playerArray: [Player]) {
        let myEncoder = PropertyListEncoder()
        let encodedPlayers = try? myEncoder.encode(playerArray)
        try? encodedPlayers?.write(to: archiveURL)
    }
    
    
    
    
    static func loadFromFile() -> [Player] {
        do {
            let myDecoder = PropertyListDecoder()
            let retrievedPlayers = try Data(contentsOf: archiveURL)
            let decodedPlayers = try myDecoder.decode(Array<Player>.self, from: retrievedPlayers)
            print(decodedPlayers)
            return decodedPlayers
        } catch {
            print(error)
            return Player.samplePlayer()
        }
}
    
    static func samplePlayer() -> [Player] {
        [Player(playerName: "Sam", currentScore: 10), Player(playerName: "Zade", currentScore: 0)]
    }
    
}


