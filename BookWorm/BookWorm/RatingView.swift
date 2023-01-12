//
//  RatingView.swift
//  BookWorm
//
//  Created by 野中淳 on 2023/01/12.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating:Int
    
    var label = ""
    
    var maximumRaging = 5
    
    var offImage:Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack{
            if label.isEmpty == false{
                Text(label)
            }else{
                ForEach(1..<maximumRaging + 1,id: \.self){ number in
                    image(for: number)
                        .foregroundColor(number > rating ? offColor : onColor)
                        .onTapGesture {
                            //tapされた番号をバインドされたratingに入れて再バインドしている
                            rating = number
                        }
                    
                }
            }
        }
    }
    
    func image(for number:Int)->Image{
        if number > rating{
            return offImage ?? onImage
        }else{
            return onImage
        }
    }
    
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
