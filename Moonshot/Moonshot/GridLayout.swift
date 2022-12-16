//
//  GridLayout.swift
//  Moonshot
//
//  Created by 野中淳 on 2022/12/15.
//

import SwiftUI

struct GridLayout: View {
    
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let astronauts:[String:Astronaut]
    let missions:[Mission]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissonView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100,height: 100)
                                .padding()
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                            .frame(maxWidth:.infinity)
                            .background(.lightBackgrounc)
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackgrounc)
                    )
                    
                }
            }
        }
    }
}

struct GridLayout_Previews: PreviewProvider {
    
    static let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        GridLayout(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
