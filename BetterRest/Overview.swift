//
//  Overview.swift
//  BetterRest
//
//  Created by Edmond Podlegaev on 05.04.2023.
//

import SwiftUI

struct Overview: View {
    
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        Overview()
    }
}
