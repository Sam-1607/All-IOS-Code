//
//  FiltersView.swift
//  Profile
//
//  Created by Sam Hiatt  on 3/15/22.
//

import SwiftUI

struct FiltersView: View {
    
    @Environment(\.dismiss) var dismiss
    
    
    @State var locationCheck = Image(systemName: "checkmark.square.fill")
    @State var loginCheck = Image(systemName: "checkmark.square.fill")
    @State var contactCheck = Image(systemName: "checkmark.square.fill")
    @State var idCheck = Image(systemName: "checkmark.square.fill")
    @State var registerCheck = Image(systemName: "checkmark.square.fill")
    
    @State var trueOrFalse = TrueOrFalseValues.shared
    @StateObject var profileCount = ProfileCount()
    
    @State var checkMark = Image(systemName: "checkmark.square.fill")
    @State var unChecked = Image(systemName: "square")
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    HStack {
                        Text("\(locationCheck)")
                            .onTapGesture {
                                changeLocationCheck()
                            }
                        Text("Location")
                    }
                    HStack {
                        Text("\(loginCheck)")
                            .onTapGesture {
                                changeLoginCheck()
                            }
                        Text("Login Info")
                    }
                    HStack {
                        Text("\(contactCheck)")
                            .onTapGesture {
                                changeContactCheck()
                            }
                        Text("Contact")
                    }
                    HStack {
                        Text("\(idCheck)")
                            .onTapGesture {
                                changeIdCheck()
                            }
                        Text("Identification")
                    }
                    HStack {
                        Text("\(registerCheck)")
                            .onTapGesture {
                                changeRegisterCheck()
                            }
                        Text("Registration Details")
                    }
                    VStack {
                        Stepper("Profile Count: \(profileCount.profileCount)", value: $profileCount.profileCount, in: 1...5000, step: Int.Stride(1))
                            .padding(.leading, 60)
                            .padding(.trailing, 60)
                            .font(.headline)
                    }
                }
                .navigationTitle("Filter Results")
                .toolbar {
                }
                NavigationLink("See Results", destination: ContentView(observedObject: profileCount))
                
            }
        }
    }
    
    func changeLocationCheck() {
        if locationCheck == checkMark {
            locationCheck = unChecked
            trueOrFalse.locationIsChecked = false
        } else {
            locationCheck = checkMark
            trueOrFalse.locationIsChecked = true
        }
    }
    func changeLoginCheck() {
        if loginCheck == checkMark {
            loginCheck = unChecked
            trueOrFalse.loginInfoIsChecked = false
        } else {
            loginCheck = checkMark
            trueOrFalse.loginInfoIsChecked = true
        }
    }
    
    func changeContactCheck() {
        if contactCheck == checkMark {
            contactCheck = unChecked
            trueOrFalse.contactIsChecked = false
        } else {
            contactCheck = checkMark
            trueOrFalse.contactIsChecked = true
        }
    }
    
    func changeIdCheck() {
        if idCheck == checkMark {
            idCheck = unChecked
            trueOrFalse.identificationIsChecked = false
        } else {
            idCheck = checkMark
            trueOrFalse.identificationIsChecked = true
        }
    }
    
    func changeRegisterCheck() {
        if registerCheck == checkMark {
            registerCheck = unChecked
            trueOrFalse.registrationInfoIsChecked = false
        } else {
            registerCheck = checkMark
            trueOrFalse.registrationInfoIsChecked = true
        }
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView()
    }
}

