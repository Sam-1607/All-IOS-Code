//
//  Question.swift
//  Personality Quiz
//
//  Created by Sam Hiatt  on 10/18/21.
//

import Foundation



struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
    
    enum ResponseType {
        case single, multiple, range
    }
}

struct Answer {
    var text: String
    var type: CharacterType
    
    enum CharacterType {
        case  Aang, Katara, Sokka, Toph
        
        var definition: String {
            switch self {
            case .Aang:
                return "You are Aang."
            case .Katara:
                return "You are Katara"
            case .Sokka:
                return     "You are Sokka"
            case .Toph:
                return "You are Toph"
            }
        }
    }
}

