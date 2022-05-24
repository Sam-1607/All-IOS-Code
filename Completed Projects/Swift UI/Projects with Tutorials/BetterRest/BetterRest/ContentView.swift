//
//  ContentView.swift
//  BetterRest
//
//  Created by Sam Hiatt  on 12/31/21.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount  = 8.0
    @State private var wakeUp = defaultWakeupTime
    @State private var coffeAmount = 1
    
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var amountsOfCoffe = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                Text("\(realBedTime)")
                            .font(.largeTitle)
                        .font(.headline)
                        Text("Suggested Bedtime")
                            .font(.subheadline)
                    }
                }
                
                Section {
                Text("When do you want to wake up")
                    .font(.headline)
                
                DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                }
                
                Section {
                Text("Desired amount of sleep")
                        .font(.headline)
                
                Stepper("\(sleepAmount.formatted()) hourse", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section {
                Text("Daily Coffee intake")
                        .font(.headline)
                
                //Stepper(coffeAmount == 1 ? "1 cup" : "\(coffeAmount) cups", value: $coffeAmount, in: 1...20 )
                    
                    Picker(coffeAmount == 1 ? "1 cup": "\(coffeAmount)", selection: $coffeAmount) {
                        ForEach(0..<21) {
                            Text("\($0) cups")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
            }
            .navigationTitle("BetterRest")
            .onAppear(perform: calculateBedTime)
//            .toolbar {
//                Button("Calculate", action: calculateBedTime)
//            }
//            .alert(alertTitle, isPresented: $showingAlert) {
//                Button("Ok") { }
//            } message: {
//                Text(alertMessage)
//            }
        }
        
    }
    var realBedTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
//            alertTitle = "your ideal betime is..."
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//            showingAlert = true
            return String(sleepTime.formatted(date: .omitted, time: .shortened))
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry there was a problem calculating your bedtime"
        }
    return ""
    }
    
    
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "your ideal betime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            showingAlert = true
            
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry there was a problem calculating your bedtime"
        }
        
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
