//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by 野中淳 on 2022/12/27.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmaton = false
    
    @ObservedObject var order:Order
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),scale: 3) { image in
                    
                    image
                        .resizable()
                        .scaledToFit()
                    
                }placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost,format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order") {
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmaton) {
            Button {
                
            } label: {
                Text("OK")
            }

        } message: {
            Text(confirmationMessage)
        }

    }
    
    func placeOrder() async{
        //送信可能なJsonデータへの変換
        guard let encoded = try? JSONEncoder().encode(order)else{
            print("Failed to encode order")
            return
        }
        //httpsリクエストの作成
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        //リクエストをサーバーに実行
        do{
            let (data,_) = try await URLSession.shared.upload(for: request, from: encoded)
            //Postで戻ってきたデータをデコード
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) × \(Order.types[decodedOrder.type].lowercased()) cupcakes is on itsh way"
            //alertに表示
            showingConfirmaton = true
        }catch{
            confirmationMessage = "Your order is failed please check you network"
            showingConfirmaton = true
        }
        
    }

    
}



struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
