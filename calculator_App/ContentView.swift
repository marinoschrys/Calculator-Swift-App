//
//  ContentView.swift
//  calculator_App
//
//  Created by Marinos Chrysostomou on 24/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var number1 = ""
    @State private var number2 = ""
    @State private var selectedOperator = ""
    @State private var result = ""
    
    let operators = ["+", "-", "*", "/"]
    
    var body: some View {
        VStack (spacing: 20){
            TextField("First Number", text: $number1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("Operation", selection: $selectedOperator) {
                ForEach(operators, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            
            TextField("Second Number", text: $number2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Calculate") {
                calculate()
            }
            .buttonStyle(.borderedProminent)
            
            Text(result)
                .font(.title)
        }
        .padding()
    }
    
    func calculate() {
        guard let num1 = Int(number1), let num2 = Int(number2) else {
            result = "Error: Invalid Input"
            return
        }
        
        var calculationResult: Int?
        
        switch selectedOperator {
        case "+": calculationResult = num1 + num2
        case "-": calculationResult = num1 - num2
        case "*": calculationResult = num1 * num2
        case "/": calculationResult = num2 != 0 ? num1/num2: nil
        default: break
        }
        
        if calculationResult != nil {
            result = "Result =  \(calculationResult!)"
        }
        else {
            result = "Error"
        }
    }
}

#Preview {
    ContentView()
}
