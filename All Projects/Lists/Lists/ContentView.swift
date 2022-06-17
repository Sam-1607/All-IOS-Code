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
    
    var body: some View {
        
        NavigationView {
            List(items) { listItem in
                Text("\(listItem.item)")
            }
            .toolbar {
                Button("Add Item") {
                    showAlert(title: "Add an Item", message: "The second Texfield is for what location you would like this item added on to the list at.", itemPlaceHolderText: "item name", importanceLevelPlacholderText: "enter a number", okbuttonTitle: "OK", cancelButtonTitle: "Cancel") { itemName in
                        self.itemName = itemName
                        
                    } itemImortanceAction: { itemImportanceText in
                        let itemImportance = Int(itemImportanceText)
                        self.itemImportance = itemImportance ?? 0
                        
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
                }
                
            }
            .navigationTitle("Notes List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

