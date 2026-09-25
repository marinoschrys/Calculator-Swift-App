//
//  CalculatorViewModel.swift
//  calculator_App
//
//  Created by Marinos Chrysostomou on 25/09/2026.
//

import SwiftUI
public import Combine


class CalculatorViewModel : ObservableObject {
    @Published var display = "0"
    
    private var previewsNumber = "0"
    private var currentOperation = ""
    private var operatorTapped = false
    private var result: Int? = nil
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
                break
            }
            result = calculateResult()!
            currentOperation = ""
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
    
    private func calculateResult() -> Int? {
        
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
        isRepeating = true
        return result
    }
}
