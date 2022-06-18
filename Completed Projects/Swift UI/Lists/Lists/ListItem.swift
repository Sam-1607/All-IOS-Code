//
//  ListItem.swift
//  Lists
//
//  Created by Sam Hiatt  on 6/15/22.
//

import Foundation

struct ListItem: Identifiable, Codable, Hashable {
    var id = UUID()
    var item: String
    var isDone = false
}
