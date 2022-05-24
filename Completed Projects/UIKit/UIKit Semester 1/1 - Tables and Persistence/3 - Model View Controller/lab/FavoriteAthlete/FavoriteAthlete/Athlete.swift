//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Sam Hiatt  on 10/6/21.
//

import Foundation
struct Athlete {
    var name: String
    var age: Int
    var league: String
    var team: String
    
    var description: String {
        return "\(name) is \(age) years old and plays for the \(team) in the \(league)"
    }
}
