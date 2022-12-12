//
//  AddView.swift
//  iExpense
//
//  Created by 野中淳 on 2022/12/04.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0

    @ObservedObject var expenses:Expenses
    
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business","Personal"]
    
    let coin = ["USD","JPN"]
    @State var selectCoin = "USD"
    
    var body: some View {
        NavigationView {
            Form{
                TextField("Name",text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types,id: \.self){
                        Text($0)
                    }
                }
                
                Picker("CoinType", selection: $selectCoin) {
                    ForEach(coin, id: \.self) { num in
                        Text(num)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: selectCoin))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
