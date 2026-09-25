//
//  ContentView.swift
//  calculator_App
//
//  Created by Marinos Chrysostomou on 24/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var previewsNumber = "0"
    @State private var currentOperation = ""
    @State private var operatorTapped = false
    @State private var result: Int? = nil
    @State private var lastOperand: Int? = nil
    @State private var isRepeating = false
    
    let buttons = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["C", "0", "=", "+"]
    ]

    var body: some View {
        VStack (spacing: 15) {
            Text(display)
                .font(.system(size: 50))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

            ForEach(buttons, id: \.self) { row in
                HStack (spacing: 10){
                    ForEach(row, id: \.self) { buttonTitle in
                        Button(action: {
                            buttonTapped(buttonTitle)
                        }) {
                            Text(buttonTitle)
                                .font(.title)
                                .frame(width: 70, height: 70)
                                .background(.black.opacity(0.2))
                                .clipShape(.circle)
                                .foregroundColor(.white)

                        }
                        .buttonStyle(.plain)
                        .glassEffect(.regular.tint(getBackgroundColor(buttonTitle)).interactive(), in: .circle)
                    }
                }
            }
        }
        .padding()
    }
    
    
    func getBackgroundColor(_ title: String) -> Color{
        switch title {
        case "C":
            return .red
        case "=":
            return .indigo
        case "+", "-", "/", "*":
            return .orange
        default:
            return Color.gray.opacity(0.2)
        }
    }
    
    
    func buttonTapped(_ title: String) {
        switch title {
        case "C":
            display = "0"
            previewsNumber = "0"
            currentOperation = ""
            isRepeating = false
            operatorTapped = false
        case "=":
            if !operatorTapped {
                break
            }
            result = calculateResult()!
            if !isRepeating {
                currentOperation = ""
            }
        case "+","-","*","/":
            operatorTapped = true
            isRepeating = false
            if currentOperation != "" {
                result = calculateResult()!
                previewsNumber = String(result!)
            }
            else {
                previewsNumber = display
            }
            currentOperation = title
            display = "0"
        default:
            if display == "0" {
                display = title
            }
            else {
                display += title
            }
            isRepeating = false
        }
    }
    
    
    func calculateResult() -> Int? {
        
        let num2: Int
        if isRepeating, let last = lastOperand {
            num2 = last
        } else {
            guard let n2 = Int(display) else { return nil}
            num2 = n2
            lastOperand = num2
        }
        
        guard let num1 = Int(previewsNumber) else { return nil}
        
        var result = 0
        
        switch currentOperation {
        case "+": result = num1 + num2
        case "-": result = num1 - num2
        case "*": result = num1 * num2
        case "/":
            if num2 != 0 {
                result = num1/num2
            }
            else {
                display = "Error"
                return nil
            }
        default: break
        }
        
        display = String(result)
        previewsNumber = String(result)
        isRepeating = true
        return result
    }
    
}

#Preview {
    ContentView()
}
