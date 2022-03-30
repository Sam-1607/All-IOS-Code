//
//  TrueOrFalse.swift
//  Profile
//
//  Created by Sam Hiatt  on 3/15/22.
//

import Foundation

class TrueOrFalseValues {
    var pictureIsChecked = true
    var nameIsChecked = true
    var locationIsChecked = true
    var loginInfoIsChecked = true
    var contactIsChecked = true
    var identificationIsChecked = true
    var registrationInfoIsChecked = true
    var profileCount = 1
    static let shared: TrueOrFalseValues = {
        let instance = TrueOrFalseValues()
        // setup code
        return instance
    }()
}

class ProfileCount: ObservableObject {
    @Published var profileCount = 1
}

