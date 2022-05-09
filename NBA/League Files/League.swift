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
    var season: String
    var start: String
    var end: String
}


struct Response: Codable {
    var response: [League]
}

struct League: Codable {
    var country: Country
    var id: Int
    var type: String
    var name: String
    var seasons: [SeasonInfo]
}


