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
    @State private var selection: Set<UUID> = []
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(.blue)]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items, selection: $selection) { listItem in
                    HStack {
                        Text("\(listItem.item)")
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    .font(.headline)
                    .padding()
                    .background(.yellow)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            self.items.removeAll {
                                $0.id == listItem.id
                            }
                        }
                    }
                }
                
                HStack {
                    Button {
                        showAlert(title: "Add an Item", message: "The second Texfield is for what location you would like this item added on to the list at, leave it empty if you don't care.", itemPlaceHolderText: "item name", importanceLevelPlacholderText: "enter a number", okbuttonTitle: "OK", cancelButtonTitle: "Cancel") { itemName in
                            self.itemName = itemName
                            
                        }
                    itemImortanceAction: { itemImportanceText in
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
                    
                    ActionSheet(title: Text("Clear"), message: Text("Are you sure you want to delete these items?"), buttons: [
                        .cancel(Text("Nevermind")),
                        .destructive(Text("Delete"), action: {
                            if selection.count > 0 {
                                let newItems = self.items.filter({selection.contains($0.id) == false })
                                self.items = newItems
                            } else {
                                self.items.removeAll()
                            }
                        })
                    ])
                }
                }
            }
            
            .toolbar {
                EditButton()
            }
            .navigationTitle("List")
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





