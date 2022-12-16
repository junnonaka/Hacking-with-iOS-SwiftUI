//
//  ListLayout.swift
//  Moonshot
//
//  Created by 野中淳 on 2022/12/15.
//

import SwiftUI

struct ListLayout: View {
    
    var colors : [Color] = [.red, .blue, .yellow, .green, .purple]
    
    let missions:[Mission]
    let astronauts:[String:Astronaut]
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink {
                    MissonView(mission: mission, astronauts: astronauts)
                    
                } label: {
                    HStack{
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                                .font(.subheadline)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                        }

                    }
                }
            }
            
        }
    }
}

struct ListLayout_Previews: PreviewProvider {
    
    static let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ListLayout(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)

    }
}
