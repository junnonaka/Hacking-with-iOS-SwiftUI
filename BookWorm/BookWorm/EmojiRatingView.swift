//
//  EmojiRatingView.swift
//  BookWorm
//
//  Created by 野中淳 on 2023/01/12.
//

import SwiftUI

struct EmojiRatingView: View {
    
    let ratting:Int16
    
    var body: some View {
        switch ratting{
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        default:
            Text("5")

        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(ratting: 4)
    }
}
