//
//  Emoji.swift
//  Emojii Dictionary
//
//  Created by Sam Hiatt  on 10/13/21.
//

import Foundation
struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    static var documentDirectory =
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static var archiveURL = documentDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    static func saveToFile(emjoiArray: [Emoji]) {
        let myEncoder = PropertyListEncoder()
        let encodedEmojis = try? myEncoder.encode(emjoiArray)
        try? encodedEmojis?.write(to: archiveURL)
    }
    
    static func loadFromFile() -> [Emoji]  {
        do {
            let myDecoder = PropertyListDecoder()
            let retrievedEmojis = try Data(contentsOf: archiveURL)
            let decodedEmojis = try myDecoder.decode(Array<Emoji>.self, from: retrievedEmojis)
            print(decodedEmojis)
            return decodedEmojis
        } catch {
            print(error)
            return Emoji.sampleEmoji()
        }
    }

    static func sampleEmoji() -> [Emoji] {
           [Emoji(symbol: "😃", name: "SmileyFace", description: "The typcal smiling face", usage: "happiness"),
            Emoji(symbol: "😂", name: "Laughing Face", description: "A face of etreme laughter", usage: "Funny"),
            Emoji(symbol: "😉", name: "Winking Face", description: "A face of someone winking", usage: "Understanding"),
            Emoji(symbol: "😍", name: "Heart Eyes Face", description: "A face of somone who is in love", usage: "Love"),
            Emoji(symbol: "🤨", name: "A Skeptical Face", description: "The face of someone who skeptical", usage: "Doubtful"),
            Emoji(symbol: "😭", name: "Crying Face", description: "Someone Bawling their eyes out", usage: "Extreme Sadness"),
            Emoji(symbol: "😡", name: "Angry Face", description: "A very angry person", usage: "Extreme Anger"),
            Emoji(symbol: "🤯", name: "Surprised", description: "A person who mind has been blown", usage: "Shock"),
            Emoji(symbol: "😥", name: "Worried Face", description: "Somenoe who is sweating because of worry", usage: "Worry"),
            Emoji(symbol: "🥱", name: "Yawning Face", description: "A face that is in the middle of yawning", usage: "Boredom"),
            Emoji(symbol: "🤮", name: "Puking Face", description: "A face that is puking", usage: "Disgust"),
            Emoji(symbol: "🧢", name: "Major Cap", description: "A blue cap", usage: "Unconvinced"),
            Emoji(symbol: "🍔", name: "Hamburger", description: "A juicy Hamburger", usage: "No idea maybe hunger or something"),
            Emoji(symbol: "💩", name: "sh*$", description: "A swirl of poo", usage: "???"),
            Emoji(symbol: "😍", name: "Simp", description: "An emoji frequently used by your local simps", usage: "Simping"),
            Emoji(symbol: "🤑", name: "Goldigger", description: "An emoji for people who care only about money", usage: "Girls in LA"),
            Emoji(symbol: "🍆", name: "Egg Plant", description: "A nice looking vegetable", usage: "When conversation about vegetables is being had")]
    }
   
}

// The Load From File is suppossed to return an array of emojis but I can't return it because retrieved emojis are not in scope


