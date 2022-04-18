//
//  ContentView.swift
//  Profile
//
//  Created by Sam Hiatt  on 3/4/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var profiles: [Profile] = []
    @State  var filterView = FiltersView()
    @State var proFileStuff = TrueOrFalseValues.shared
    @ObservedObject var observedObject: ProfileCount
    
    var urlProfileCountString = "?results="
    var body: some View {
        NavigationView {
            List(profiles, id: \.login.password) { profile in
                
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: "\(profile.picture.thumbnail)")) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    
                    Section(header: Text("Name")) {
                        HStack(alignment: .center) {
                            Text(String(describing: profile.name.title))
                            Text(String(describing: profile.name.first))
                            Text(String(describing: profile.name.last))
                        }
                    }
                    
                    
                    if TrueOrFalseValues.shared.locationIsChecked == true {
                        Section(header: Text("Location")) {
                            HStack(alignment: .center) {
                                Text(String(describing: profile.location.state))
                                Text(String(describing: profile.location.city))
                            }
                        }
                    }

                    if filterView.trueOrFalse.loginInfoIsChecked == true {
                        Section(header: Text("Login Info")) {
                            VStack {
                                VStack(alignment: .center) {
                                    HStack {
                                        Text("Username: ")
                                        Text(String(describing: profile.login.username))
                                    }
                                    HStack {
                                        Text("Password: ")
                                        Text(String(describing: profile.login.password))
                                    }
                                }
                                HStack {
                                    Text("Email: ")
                                    Text(String(describing: profile.email))
                                }
                            }
                        }
                    }
                    
                    if filterView.trueOrFalse.contactIsChecked == true {
                        Section(header: Text("Contact")) {
                            VStack(alignment: .center) {
                                HStack {
                                    Text("Cell: ")
                                    Text(String(describing: profile.cell))
                                }
                                HStack {
                                    Text("Phone: ")
                                    Text(String(describing: profile.phone))
                                }
                            }
                        }
                    }
                    
                    if filterView.trueOrFalse.identificationIsChecked == true {
                        Section(header: Text("Identification")) {
                            VStack(alignment: .center) {
                                HStack {
                                    Text("Gender: ")
                                    Text(String(describing: profile.gender))
                                }
                                HStack {
                                    Text("DOB: ")
                                    Text(String(describing: profile.dob.date))
                                }
                                HStack {
                                    Text("Age: ")
                                    Text(String(describing: profile.dob.age))
                                }
                            }
                        }
                    }
                    
                    if filterView.trueOrFalse.registrationInfoIsChecked == true {
                        Section(header: Text("Registration Details")) {
                            VStack(alignment: .center) {
                                HStack {
                                    Text("Date Registered: ")
                                    Text(String(describing: profile.registered.date))
                                }
                                HStack {
                                    Text("Age Registered: ")
                                    Text(String(describing: profile.registered.age.formatted()))
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Profiles")
        }
        .onAppear {
            fetch2()
            print(filterView.trueOrFalse.locationIsChecked)
        }
    }
    func fetch2() {
        let urlComponents  = URLComponents(string: "https://randomuser.me/api/?results=\(observedObject.profileCount)")
        let task = URLSession.shared.dataTask(with: (urlComponents?.url)!) { (data, response, error) in
            if let response = response {
                print(response)
            }
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let decodedProfiles = try decoder.decode(Response.self, from: data)
                    print(decodedProfiles)
                    profiles = decodedProfiles.results
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(observedObject: ProfileCount())
    }
}
