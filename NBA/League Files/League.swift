//
//  League.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/12/22.
//

import Foundation
import UIKit
var leagueUrl = URL(string: "https://api-basketball.p.rapidapi.com/leagues")

struct Country: Codable {
    var name: String
    var flag: String?
}

struct SeasonInfo: Codable {
    var season: Int
    var start: String
    var end: String
}

struct Season: Codable {
    var obj1: SeasonInfo
    var obj2: SeasonInfo
    var obj3: SeasonInfo
    var obj4: SeasonInfo
}

struct Response: Codable {
    var response: [League]
}

struct League: Codable {
    var country: Country
    var id: Int
    var type: String
    var name: String
    var seasons: [Season]
}

// Do I need to have an API call for every type of Object or can I just use 1 api call

