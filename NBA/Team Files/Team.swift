//
//  Team.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/9/22.
//

import Foundation

struct TeamResponse: Codable {
    var response: [Team]
}

struct TeamCountry: Codable {
    var flag: String
    var name: String
}

struct Team: Codable {
    var name: String
    var nationnal: Bool
    var logo: String
    var country: TeamCountry
}
