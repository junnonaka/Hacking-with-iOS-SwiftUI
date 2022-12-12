//
//  AstronautView.swift
//  Moonshot
//
//  Created by 野中淳 on 2022/12/12.
//

import SwiftUI

struct AstronautView: View {
    let astronaut:Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding()
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static var previews: some View {
        
        let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
        
        AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
    }
}
