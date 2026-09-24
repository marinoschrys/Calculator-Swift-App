//
//  ContentView.swift
//  calculator_App
//
//  Created by Marinos Chrysostomou on 24/09/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var previewsNumber = ""
    @State private var currentOperation = ""
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
                HStack (spacing: 12){
                    ForEach(row, id: \.self) { buttonTitle in
                        Button(action: {
                            buttonTapped(buttonTitle)
                        }) {
                            Text(buttonTitle)
                                .font(.title)
                                .frame(width: 70, height: 70)
                                .background(getBackgroundColor(buttonTitle))
                                .clipShape(.circle)
                                .foregroundColor(.white)
                        }
                        .frame(width: 70, height: 70)
                        .buttonStyle(.plain)
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
            previewsNumber = ""
            currentOperation = ""
            isRepeating = false
        case "=": calculateResult()
        case "+","-","*","/":
            previewsNumber = display
            currentOperation = title
            display = "0"
        default:
            if display == "0" {
                display = title
            }
            else {
                display += title
            }
        }
    }
    
    func calculateResult() {
        
        let num2: Int
        if isRepeating, let last = lastOperand {
            num2 = last
        } else {
            guard let n2 = Int(display) else { return }
            num2 = n2
            lastOperand = num2
        }
        
        guard let num1 = Int(previewsNumber) else { return }
        
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
                return
            }
        default: break
        }
        
        display = String(result)
        previewsNumber = String(result)
        isRepeating = true
    }
    
}

#Preview {
    ContentView()
}
