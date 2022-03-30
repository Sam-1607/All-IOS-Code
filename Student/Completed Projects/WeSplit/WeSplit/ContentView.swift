//
//  ContentView.swift
//  WeSplit
//
//  Created by Sam Hiatt  on 12/20/21.
//

import SwiftUI

struct UseRed: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.red)
    }
}




struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currencyCode ?? "USD")
    // let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        let useRedText = tipPercentage == 0
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<100) {
                            Text($0, format: .percent)
                                
                        }
                        .pickerStyle(.automatic)
                    }
                    
                    
                } header: {
                    Text("How much tip do you want to leave")
                }
                
                
                
                
                
                
                Section {
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("Amount per person")
                }
                
                Section {
                    
                    Text("\(totalPerPerson * Double(numberOfPeople + 2), format: .number)")
                        .foregroundColor(useRedText ? .red : .black)
                } header: {
                    Text("Grand Total")
                }
                
                
                
                
            }
            .navigationTitle("WeSplit")
            
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                    
                }
            }
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
