//
//  TeamsAll.swift
//  NBA
//
//  Created by Sam Hiatt  on 5/18/22.
//

import Foundation

struct AllTeamsResponse: Codable {
    var response: [AllTeams]
}

struct AllTeams: Codable, TeamCollectionRequireMents {
    var seasonStuff: [Season]? {
        return nil
    }
    
   
    
    var displayText: String? {
        return name
    }
    
    var displayImage: String? {
        return logo
    }
    
    var ids: Int? {
        return id
    }
    
    var id: Int
    var name: String
    var logo: String
}
