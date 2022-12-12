//
//  ExpenseItem.swift
//  iExpense
//
//  Created by 野中淳 on 2022/11/30.
//

import Foundation

struct ExpenseItem:Identifiable,Codable{
    var id = UUID()
    let name:String
    let type:String
    let amount:Double
}
