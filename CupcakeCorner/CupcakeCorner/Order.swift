//
//  Order.swift
//  CupcakeCorner
//
//  Created by 野中淳 on 2022/12/26.
//

import Foundation

class Order:ObservableObject,Codable{
    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddresss = ""
    @Published var city = ""
    @Published var zip = ""
    
    enum CodingKeys:CodingKey{
        case type,quantity,extraFrosting,addSprinkles,name,streetAddresss,city,zip
    }
    
    //encodeする方法をSwiftに教えている
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddresss, forKey: .streetAddresss)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)

    }
    //デコードする方法をSwiftに教えている
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddresss = try container.decode(String.self, forKey: .streetAddresss)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    init(){}

    
    var hasValidAddress:Bool{
        if name.isEmpty || streetAddresss.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        }
        return true
    }
    
    var cost:Double{
        
        var cost = Double(quantity) * 2
        
        cost += (Double(type)/2)
        
        if extraFrosting{
            cost += Double(quantity) / 2
        }
        return cost
    }
    
    
    
}
