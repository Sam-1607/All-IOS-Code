//
//  ContentView.swift
//  UserNames
//
//  Created by Sam Hiatt  on 3/3/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var namesList = NamesList()
    @State var newName: String = ""
    @State var showAlert = false
    
    var textField : some View {
        HStack {
            TextField("Enter Name", text: self.$newName)
            
            Button("\(Image(systemName: "plus"))") {
                if newName != "" {
                    addName()
                    newName = ""
                } else {
                    return
                }
            }
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
            textField
                .padding()
            
            List(self.namesList.names) { name in
                Text(name.user)
                
            }
                Button("Select Random") {
                    showAlert = true
                    selectRandom()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Name Selected"), message:Text("\(self.namesList.names[0].user)"), dismissButton: .cancel(Text("Done"), action: {
                        showAlert = false
                    }))
                    
                }
            } .navigationTitle("Names List")
        }
    }
    
    func addName() {
        namesList.names.append(User(id: String(namesList.names.count + 1), user: newName))
    }
    
    func selectRandom() {
        namesList.names.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
