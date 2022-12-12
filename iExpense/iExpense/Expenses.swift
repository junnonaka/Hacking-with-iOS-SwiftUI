//
//  Expenses.swift
//  iExpense
//
//  Created by 野中淳 on 2022/12/05.
//

import Foundation

class Expenses:ObservableObject{
    @Published var items = [ExpenseItem](){
        //値が設定されたらUserDefaultに保存する
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let docodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = docodedItems
                return
            }
        }
        //無い、もしくは失敗した場合
        items = []
        
    }
}
