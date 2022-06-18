//
//  ContentView.swift
//  Lists
//
//  Created by Sam Hiatt  on 6/15/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var items: [ListItem] = []
    @State var itemName: String = ""
    @State var itemImportance: Int = 0
    @State var isShowing = false
    @State var systemImage = "circle"
    @State private var selection: UUID?
    
    var body: some View {
        NavigationView {
            VStack {
                List(items, selection: $selection) { listItem in
                    HStack {
                        Text("\(listItem.item)")
                            .font(.headline)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Delete", role: .destructive) {
                                    self.items.removeAll {
                                        $0.id == listItem.id
                                    }
                                }
                            }
                    }
                }
                
                HStack {
                Button {
                    showAlert(title: "Add an Item", message: "The second Texfield is for what location you would like this item added on to the list at.", itemPlaceHolderText: "item name", importanceLevelPlacholderText: "enter a number", okbuttonTitle: "OK", cancelButtonTitle: "Cancel") { itemName in
                        self.itemName = itemName
                        
                    }
                itemImortanceAction: { itemImportanceText in
                        let itemImportance = Int(itemImportanceText)
                        self.itemImportance = itemImportance ?? 0
                        self.systemImage = "circle"
                        if self.itemImportance <= self.items.count {
                            if self.itemImportance > 0  {
                                let myIndex = self.itemImportance - 1
                                self.items.insert(ListItem(item: itemName), at: myIndex)
                                self.itemImportance = 0
                            } else  {
                                self.items.insert(ListItem( item: itemName), at: 0)
                                self.itemImportance = 0
                            }
                        } else {
                            self.items.append(ListItem(item: itemName))
                            self.itemImportance = 0
                        }
                    } secondaryAction: {
                        print("Canceled")
                    }
                } label: {
                    Label("", systemImage: "plus")
                }
                .font(.title)
                .padding(.leading, 30)
                Spacer()
                
                
                Button {
                    isShowing.toggle()
                }
                
            label: {
                Label("", systemImage: "trash")
                    .font(.title)
            }
            .padding(.trailing, 30)
            .actionSheet(isPresented: $isShowing) {
                ActionSheet(title: Text("Clear List"), message: Text("Are you sure you want to delete \(self.items.count) items"), buttons: [
                    .cancel(Text("Nevermind")),
                    .destructive(Text("Delete"), action: {
                        self.items.removeAll()
                    })
                ])
            }
                }
            }
            
            .toolbar {
                EditButton()
            }
            .navigationTitle("Shopping List")
        }
    }
    
    //MARK: Save and Calling Data
    
    func saveMyData(items: [ListItem]) {
        let encoder = JSONEncoder()
        if let encodedItems = try? encoder.encode(items) {
            let defaults = UserDefaults.standard
            defaults.set(encodedItems, forKey: "SavedItems")
        }
    }
    
    func callMyData(items: [ListItem]) {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.data(forKey: "SavedItems") {
            if let decodedItems = try? decoder.decode([ListItem].self, from: data) {
                self.items = decodedItems
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

