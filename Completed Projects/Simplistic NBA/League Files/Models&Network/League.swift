//
//  League.swift
//  NBA
//
//  Created by Sam Hiatt  on 4/12/22.
//

import Foundation
import UIKit

var leagueUrl = URL(string: "https://api-basketball.p.rapidapi.com/leagues")

struct Response: Codable {
    var response: [League]
}

struct League: Codable {
    var country: Country
    var id: Int
    var name: String
    var logo: String?
    var seasons: [Season]
}

struct Country: Codable {
    var name: String
    var flag: String?
}

struct SeasonResponse: Codable {
    var response: [Season]
}

struct Season: Codable {
    let season: StringOrInt
    let start: String
    let end: String
}

enum StringOrInt: Codable {
    
    case string(String)
    case int(Int)
    
    init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            self = .int(int)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        throw Error.couldNotFindStringOrDouble
    }
    enum Error: Swift.Error {
        case couldNotFindStringOrDouble
    }
}
