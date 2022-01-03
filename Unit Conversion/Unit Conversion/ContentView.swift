//
//  ContentView.swift
//  Unit Conversion
//
//  Created by Jonas Jacobs on 12/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var firstAmount = ""
    @State private var firstUnit = 0
    @State private var secondUnit = 0
    
    let firstMetric = ["Meters", "kiliometers"]
    let secondMetric = ["Feet", "Inches"]
    
    var computedVariable: Double {
        var first = Double(firstAmount) ?? 0
        
        switch firstUnit {
        case 0:
            return first * 1000
        case 1:
            return first * 1_000_000
        default :
            return 0
        }
    }
    
    var imperialConversion: Measurement<UnitLength> {
        let imperial = computedVariable
        let distance = Measurement(value: imperial, unit: UnitLength.millimeters)
        let feet = distance.converted(to: UnitLength.feet)
        let inches = distance.converted(to: UnitLength.inches)
        
        switch secondUnit {
        case 0:
            return feet
        case 1:
            return inches
        default:
            return distance
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section{
                    TextField("Amount", text: $firstAmount)
                        .keyboardType(.decimalPad)
                    Picker("Select conversion from", selection: $firstUnit) {
                        ForEach(0 ..< firstMetric.count) {
                            Text("\(self.firstMetric[$0])")
                                .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    Picker("Select Conversion to", selection: $secondUnit) {
                        ForEach(0 ..< secondMetric.count) {
                            Text("\(self.secondMetric[$0])")
                        }
                    }
                }
                Section {
                    Text("\(imperialConversion.description)")
                }
            }
            .navigationBarTitle("Unit Convertion,", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
