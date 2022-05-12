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
    var type: String
    var name: String
    var logo: String?
    var seasons: [Season]
}

struct Country: Codable {
    var name: String
    var flag: String?
}

struct Seasons: Codable {
    let seasons: [Season]
}

struct Season: Codable {
    let season: StringOrDouble
    let start: String
    let end: String
}

enum StringOrDouble: Codable {
    
case string(String)
case double(Double)
    
    init(from decoder: Decoder) throws {
        if let double = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(double)
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
