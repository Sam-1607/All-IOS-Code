//
//  User.swift
//  UserNames
//
//  Created by Sam Hiatt  on 3/3/22.
//

import Foundation
import SwiftUI
import Combine

struct User: Identifiable {
    var id = String()
    var user = String()
}

class NamesList: ObservableObject {
  @Published var names = [User]()
}
