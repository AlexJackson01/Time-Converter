//
//  ContentView.swift
//  Time Converter
//
//  Created by Alex Jackson on 23/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var input: Double?
    @State private var output: Double?
    @State private var unitOne = "Minutes"
    @State private var unitTwo = "Hours"
    @FocusState private var inputIsFocused: Bool

    let timeUnits = ["Hours", "Minutes", "Seconds", "Days"]

    func convertToSeconds(input: Double) -> Double {
        switch unitOne {
        case "Hours":
            return input * 3600
        case "Minutes":
            return input * 60
        case "Seconds":
            return input
        case "Days":
            return input * 86400
        default:
            return 0
        }
    }

    var convertedValue: Double {
        switch unitTwo {
        case "Hours":
            return convertToSeconds(input: input ?? 0) / 3600
        case "Minutes":
            return convertToSeconds(input: input ?? 0) / 60
        case "Seconds":
            return convertToSeconds(input: input ?? 0)
        case "Days":
            return convertToSeconds(input: input ?? 0) / 86400
        default:
            return 0
        }
    }

    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    TextField(
                        "Time to convert", value: $input, format: .number
                    )
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)

                    Picker("From", selection: $unitOne) {
                        ForEach(timeUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }

                    Picker("To", selection: $unitTwo) {
                        ForEach(timeUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }

                Section("Output") {
                    Text(convertedValue, format: .number)
                }
            }
            .navigationTitle("Time converter")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
