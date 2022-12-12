//
//  ContentView.swift
//  iExpense
//
//  Created by 野中淳 on 2022/11/27.
//

import SwiftUI



struct ContentView: View {
    
    //ExpensesのインスタンスをStateObjectに設定
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items, content: { item in
                    HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }

                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                })
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    //let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    //expenses.item.append(expense)
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }
    
    func removeItem(at offset:IndexSet){
        expenses.items.remove(atOffsets: offset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
