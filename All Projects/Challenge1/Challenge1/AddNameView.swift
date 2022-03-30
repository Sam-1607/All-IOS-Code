//
//  AddNameView.swift
//  Challenge1
//
//  Created by Sam Hiatt  on 3/2/22.
//

import SwiftUI


struct AddNameView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var name: String
    @State private var names = Group()
    @State private var allNames = User2()
    var body: some View {
        VStack(alignment: .center) {
            
            Text("Enter Your New Name Here")
                .font(.system(size: 25))
            
            TextField("name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.leading, 50)
                .padding(.trailing, 50)
                .onAppear {
                    name = ""
                }
            
            Button("Submit") {
                addName()
                dismiss()
                print(allNames)
            }
            .padding()
        }
        
    }
    
    // MARK: Functions
    
    func addName() {
        let array = [name]
        allNames.users += array
      //  names.allNames.insert(name, at: 0)
    }
}


struct AddNameView_Previews: PreviewProvider {
    static var previews: some View {
        AddNameView()
    }
}
