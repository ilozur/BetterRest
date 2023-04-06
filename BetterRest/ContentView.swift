//
//  ContentView.swift
//  BetterRest
//
//  Created by Edmond Podlegaev on 05.04.2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    @State private var coffeePossibly = [1, 2, 3, 4, 5, 6, 7, 8]
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please, enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        Picker("Coffee", selection: $coffeeAmount) {
                            ForEach (coffeePossibly, id: \.self) {
                                Text($0, format: .number)
                            }
                        }
                        .pickerStyle(.segmented )
                        .labelsHidden()
                    }
                }
                
                Section {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Your ideal bedtime is")
                            .font(.headline)
                        Text(verbatim: calculateBedTime())
                            .font(.largeTitle)
                    }
                }
            }
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedTime() -> String{
        var answer: String = ""
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            var components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            var hour = (components.hour ?? 0) * 60 * 60
            var minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            components = Calendar.current.dateComponents([.hour, .minute], from: sleepTime)
            hour = components.hour ?? 0
            minute = components.minute ?? 0
            
            let answerHour: String = hour < 9 ? "0\(String(hour))" : "\(String(hour))"
            let answerMinute: String = minute < 9 ? "0\(String(minute))" : "\(String(minute))"
            
            answer = "\(answerHour):\(answerMinute)"
            
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
            showingAlert = true
        }
        return answer
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
