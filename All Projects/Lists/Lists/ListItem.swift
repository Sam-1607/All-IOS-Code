//
//  ListItem.swift
//  Lists
//
//  Created by Sam Hiatt  on 6/15/22.
//

import Foundation

struct ListItem: Identifiable, Codable {
    var id = UUID()
    var item: String
}
