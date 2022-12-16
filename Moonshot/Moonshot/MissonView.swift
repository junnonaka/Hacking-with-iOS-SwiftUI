//
//  MissonView.swift
//  Moonshot
//
//  Created by 野中淳 on 2022/12/10.
//

import SwiftUI

struct MissonView: View {
    
    struct CrewMember {
        let role:String
        let astronaut:Astronaut
    }
    
    let crew:[CrewMember]

    init(mission:Mission,astronauts:[String:Astronaut]){
        self.mission = mission
        self.crew = mission.crew.map({ member in
            if let astranaut = astronauts[member.name]{
                return CrewMember(role: member.role, astronaut: astranaut)
            }else{
                fatalError("Missint\(member.name)")
            }
        })
    }
    

    let mission:Mission
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.darkBackground)
                        .padding(.vertical)
                    Text("\(mission.formattedLaunchDate)")
                        .font(.system(size: 30))
                    Spacer()
                    VStack(alignment:.leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom)
                        Text(mission.description)
                        
                    }
                    .padding(.horizontal)
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom,5)
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack{
                            ForEach(crew,id:\.role) { crewMember in
                                NavigationLink {
                                    AstronautView(astronaut: crewMember.astronaut)
                                } label: {
                                    ClueView(crewMember: crewMember)
//                                    HStack{
//                                        Image(crewMember.astronaut.id)
//                                            .resizable()
//                                            .frame(width: 104,height: 72)
//                                            .clipShape(Capsule())
//                                            .overlay(
//                                                Capsule()
//                                                    .strokeBorder(.white,lineWidth: 1)
//                                            )
//                                        VStack(alignment: .leading) {
//                                            Text(crewMember.astronaut.name)
//                                                .foregroundColor(.white)
//                                                .font(.headline)
//                                            Text(crewMember.role)
//                                                .foregroundColor(.secondary)
//
//                                        }
//                                    }
                                    .padding()
                                }

                            }
                        }
                    }
                }
                .padding(.bottom)
                
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissonView_Previews: PreviewProvider {
    static let missions:[Mission] = Bundle.main.decode("missions.json")
    
    static let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissonView(mission: missions[0],astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
