//
//  ContentView.swift
//  calculator_App
//
//  Created by Marinos Chrysostomou on 24/09/2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = CalculatorViewModel()
    
    let buttons = [
        ["7", "8", "9", "/"],
        ["4", "5", "6", "*"],
        ["1", "2", "3", "-"],
        ["C", "0", "=", "+"]
    ]

    var body: some View {
        VStack (spacing: 15) {
            Text(vm.display)
                .font(.system(size: 50))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

            ForEach(vm.buttons, id: \.self) { row in
                HStack (spacing: 10){
                    ForEach(row, id: \.self) { buttonTitle in
                        Button(action: {
                            vm.buttonTapped(buttonTitle)
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
}

#Preview {
    ContentView()
}
