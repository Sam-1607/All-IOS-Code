//
//  Representative.swift
//  API Project
//
//  Created by Sam Hiatt  on 11/22/21.
//

import Foundation
import UIKit
struct Representative: Codable {
    var party: String
    var name: String
    var link: String
    enum CodingKeys: String, CodingKey {
        case party
        case name
        case link
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        party = try values.decode(String.self, forKey: CodingKeys.party)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        link = try values.decode(String.self, forKey: CodingKeys.link)
    }
}

struct SearchResponse: Codable {
    let results: [Representative]
}

