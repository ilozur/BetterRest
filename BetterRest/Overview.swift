//
//  Overview.swift
//  BetterRest
//
//  Created by Edmond Podlegaev on 05.04.2023.
//

import SwiftUI

struct Overview: View {
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                .padding(25)
            DatePicker("Please, enter a date", selection: $wakeUp, in: Date.now..., displayedComponents: .date)
            DatePicker("Please, enter a time", selection: $wakeUp, in: Date.now..., displayedComponents: .hourAndMinute)
                .labelsHidden()
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
    }
    
    func notTrivialExample() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        var date = Calendar.current.date(from: components) ?? Date.now
    }
    
//    func trivialExample() {
//        let now = Date.now
//        let tomorrow = Date.now.addingTimeInterval(86400)
//        let range = now...tomorrow
//    }
    
//    func exampleData() {
//        let tomorrow = Date.now.addingTimeInterval(86400)
//        let range = Date.now...tomorrow
//    }
    
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
