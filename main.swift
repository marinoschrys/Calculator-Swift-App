//
//  main.swift
//  calculator
//
//  Created by Marinos Chrysostomou on 22/09/2026.
//

import Foundation

print("Welcome! Please type an integer number:")

if let input1 = readLine(), let num1 = Int(input1) {
    print("Please type a second number:")
    if let input2 = readLine(), let num2 = Int(input2) {
        print("Select equation: +, -, *, /")
        if let eq = readLine() {
            var result: Int?
            switch eq {
                case "+":
                    result = num1 + num2
                case "-":
                    result = num1 - num2
                case "*":
                    result = num1*num2
                case "/":
                    if num2 == 0 {
                        print("Error")
                    } else {
                        result = num1/num2
                    }
                default:
                    print("Error")
            }
            if result != nil {
                print(result!)
            }
        }
    }
    
}
