//
//  League.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/12/22.
//

import Foundation

var leagueUrl = URL(string: "https://api-basketball.p.rapidapi.com/leagues")

struct League: Codable {
    var country: String
    var id: Int
    var type: String
    var season: String
    var name: String
    var code: String
    var search: String
}

