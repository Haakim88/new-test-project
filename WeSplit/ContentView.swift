//
//  ContentView.swift
//  WeSplit
//
//  Created by Amir Gurung on 04/10/2022.


import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.00
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 1
    
    @FocusState private var amountIsFocused: Bool
    
    let localCurrency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalWithTips: Double {
        let _ = Double(numberOfPeople + 2)
        let tipSelection1 = Double(tipPercentage)
        
        let tipValue1 = checkAmount / 100 * tipSelection1
        let grandTotal1 = checkAmount + tipValue1
        
        return grandTotal1
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value", value: $checkAmount, format:localCurrency)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        .foregroundColor(.red)
                        .background(Color.gray)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                                .border(.black)
                        }
                    }.pickerStyle(.automatic)
                }
                
                
                Section {
                
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                                .border(.black)

                               
                        }
                    }
                } header: {
                    Text("How much tip would you like to leave?")
                        .foregroundColor(.black)
                        .background(Color("Color1"))
                 
                }
                
                
                Section {
                    Text(totalWithTips, format: localCurrency)
                } header: {
                    Text("Total Amount with Tips")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(.black)

                }
                
                
                Section {
                    Text(totalPerPerson, format: localCurrency)
                } header: {
                    Text("Amount per Person")
                        .font(.system(size: 20, weight: .medium, design: .default))
                }
                
            }
            .navigationTitle("We-Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                        
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
