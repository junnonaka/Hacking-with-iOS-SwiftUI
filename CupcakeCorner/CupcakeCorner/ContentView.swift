//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by 野中淳 on 2022/12/23.
//

import SwiftUI

final class User:ObservableObject,Codable{
    
    @Published var name = "jun Nonaka"
    @Published var middleName = "Smith"
    
    enum CokingKeys:CodingKey{
        case name
        case middleName
    }
    
    required init(from decoder:Decoder)throws{
        let container = try decoder.container(keyedBy: CokingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CokingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
}

struct Response:Codable{
    var results:[Result]
}

struct Result:Codable{
    var trackId:Int
    var trackName:String
    var collectionName:String
}





struct ContentView: View {
    
    @StateObject var order = Order()
    
    @State private var username = ""
    @State private var email = ""
    
    var disableForm:Bool{
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes\(order.quantity)", value: $order.quantity, in: 3...20)
                    
                }
                Section{
                    Toggle("Any Special requests?",isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled{
                        Toggle("Add extra frosting",isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles",isOn: $order.addSprinkles)
                    }
                }
                
                Section{
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delevery details")
                    }

                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
