//
//  ContentView.swift
//  UnitConversion
//
//  Created by Sam Hiatt  on 12/21/21.
//

import SwiftUI
struct ContentView: View {
    
    @State private var inputTextField: Double? = 0.0
    @State private var outPutTextView =  0.0
    
    
    @State private var selectedInput = "Feet"
    @State private var selectedOutput = "Feet"
    let  lengthOptions = ["Feet", "Miles", "Kilometers", "Yards"]
    let  conversionOptions = ["Feet", "Miles", "Kilometers", "Yards"]
    
    var logic: Double {
        guard let inputTextField = inputTextField else { return 0.0 }
        var answer = outPutTextView
        
    if selectedInput == lengthOptions[0] && selectedOutput == conversionOptions[0] {
        answer = inputTextField * 1
        
            }
        else if selectedInput == lengthOptions[0] && selectedOutput == conversionOptions[1] {
            answer = inputTextField / 5280
            
        } else if selectedInput == lengthOptions[0] && selectedOutput == conversionOptions[2] {
            answer = inputTextField / 3280.84
            return answer
            
        } else if selectedInput == lengthOptions[0] && selectedOutput == conversionOptions[3] {
            answer = inputTextField / 3
        }
        else if selectedInput == lengthOptions[1] && selectedOutput == conversionOptions[0] {
            answer = inputTextField * 5280
        }
        else if selectedInput == lengthOptions[1] && selectedOutput == conversionOptions[1] {
            answer = inputTextField * 1
        }
        else if selectedInput == lengthOptions[1] && selectedOutput == conversionOptions[2] {
            answer = inputTextField * 1.60934
        }
        else if selectedInput == lengthOptions[1] && selectedOutput == conversionOptions[3] {
            answer = inputTextField * 1760
        }
        else if selectedInput == lengthOptions[2] && selectedOutput == conversionOptions[0] {
            answer = inputTextField * 3280.84
        }
        else if selectedInput == lengthOptions[2] && selectedOutput == conversionOptions[1] {
            answer = inputTextField * 0.621371
        }
        else if selectedInput == lengthOptions[2] && selectedOutput == conversionOptions[2] {
            answer = inputTextField * 1
        }
        else if selectedInput == lengthOptions[2] && selectedOutput == conversionOptions[3] {
            answer = inputTextField * 1093.61
        } else if selectedInput == lengthOptions[3] && selectedOutput == conversionOptions[0] {
            answer = inputTextField * 3
        }
        else if selectedInput == lengthOptions[3] && selectedOutput == conversionOptions[1] {
    answer = inputTextField / 1760
        }
        else if selectedInput == lengthOptions[3] && selectedOutput == conversionOptions[2] {
            answer = inputTextField / 1093.61
        }
        else if selectedInput == lengthOptions[3] && selectedOutput == conversionOptions[3] {
            answer = inputTextField * 1
        }
        return answer
    }
    
    
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    Picker("Select a Unit to Convert", selection: $selectedInput) {
                        ForEach(lengthOptions, id: \.self) {
                            Text($0)
                        }
                        
                        
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("", value: $inputTextField, format: .number )
                        .padding()
                    
                } header: {
                    Text("What type of Unit to convert")
                }
                
                
                Section {
                    Picker("Select Unit type to Convert to", selection: $selectedOutput) {
                        ForEach(conversionOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Text("\(logic.formatted())")
                    
                } header: {
                    Text("What type of Unit to conver to")
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
