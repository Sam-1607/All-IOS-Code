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

struct AllTeams: Codable {
    var id: Int
    var name: String
    var logo: String
}
