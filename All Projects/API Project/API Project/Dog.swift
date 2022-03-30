//
//  Dog.swift
//  API Project
//
//  Created by Sam Hiatt  on 11/19/21.
//

import Foundation
struct Dog: Codable {
    var status: String
    var message: URL
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }
}
