//
//  CalculatorViewModel.swift
//  calculator_App
//
//  Created by Marinos Chrysostomou on 25/09/2026.
//

import SwiftUI
import Combine


class CalculatorViewModel : ObservableObject {
    @Published var display = "0"
    
    private var previewsNumber = "0"  //holds the previews number or the first number of the equation
    private var currentOperation = ""
    private var operatorTapped = false
    private var result: Int = 0
    private var lastOperand: Int? = nil
    private var isRepeating = false
    
    let buttons = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["C", "0", "=", "+"]
    ]
    
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
                previewsNumber = display
            }
            result = calculateResult()
            //currentOperation = ""
            operatorTapped = false
        case "+","-","*","/":
            isRepeating = false
            if operatorTapped {
                result = calculateResult()
                previewsNumber = String(result)
            }
            else {
                previewsNumber = display
            }
            operatorTapped = true
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
    
    private func calculateResult() -> Int {
        
        let num2: Int
        if isRepeating, let last = lastOperand {
            num2 = last
        } else {
            guard let n2 = Int(display) else { return 0 }
            num2 = n2
            lastOperand = num2
        }
        
        guard let num1 = Int(previewsNumber) else { return 0 }
        
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
                return 0
            }
        default: break
        }
        
        display = String(result)
        isRepeating = true
        return result
    }
}
