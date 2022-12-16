//
//  ClueView.swift
//  Moonshot
//
//  Created by 野中淳 on 2022/12/14.
//

import SwiftUI

struct ClueView: View {
    
    
    let crewMember:MissonView.CrewMember

    var body: some View {
        HStack{
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104,height: 72)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(.white,lineWidth: 1)
                )
            VStack(alignment: .leading) {
                Text(crewMember.astronaut.name)
                    .foregroundColor(.white)
                    .font(.headline)
                Text(crewMember.role)
                    .foregroundColor(.secondary)

            }
        }
    }
}

struct ClueView_Previews: PreviewProvider {
    
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ClueView(crewMember: MissonView.CrewMember(role: "test", astronaut: astronauts["white"]!))
    }
}
