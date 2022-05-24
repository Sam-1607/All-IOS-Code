//
//  StoreItems.swift
//  iTunesSearch
//
//  Created by Sam Hiatt  on 11/17/21.
//

import Foundation
struct StoreItem: Codable {
    var artistName: String
    var trackName: String
    var kind: String
    var artWorkURL: URL
    var longDescription: String?
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case kind
        case artWorkURL = "artworkUrl100"
        case description = "shortDescription"
    }
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        trackName = try values.decode(String.self, forKey: CodingKeys.trackName)
        artistName = try values.decode(String.self, forKey: CodingKeys.artistName)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artWorkURL = try values.decode(URL.self, forKey: CodingKeys.artWorkURL)
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
    
    
}
struct SearchResponse: Codable {
    let results: [StoreItem]
}

