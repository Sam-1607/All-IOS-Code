//
//  Profile.swift
//  Profile
//
//  Created by Sam Hiatt  on 3/4/22.
//

import Foundation
import SwiftUI

struct Response: Codable {
    var results: [Profile]
}
struct Profile: Codable {
    var gender: String
    var name: Name
    var location: Location
    var email: String
    var login: Login
    var registered: Registered
    var dob: DOB
    var phone: String
    var cell: String
    var picture: Picture
    var nat: String
}

struct Name: Codable {
    var title: String
    var first: String
    var last: String
}

struct Location: Codable {
    var street: Street
    var city: String
    var state: String
    var coordinates: Coordinates
}

struct Coordinates: Codable {
    var longitude: String
    var latitude: String
}
struct Street: Codable {
    var number: Int
    var name: String
}

struct Login: Codable {
    var uuid: String
    var username: String
    var password: String
    var salt: String
    var md5: String
    var sha1: String
    var sha256: String
}

struct DOB: Codable {
    var date: String
    var age: Int
}

struct Picture: Codable {
    var thumbnail: String
}
struct Registered: Codable {
    var date: String
    var age: Int
}

