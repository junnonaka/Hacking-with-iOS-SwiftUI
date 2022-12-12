//
//  ContentView.swift
//  Moonshot
//
//  Created by 野中淳 on 2022/12/06.
//

import SwiftUI

struct ContentView: View {
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    let astronauts:[String:Astronaut] = Bundle.main.decode("astronauts.json")
    let missions:[Mission] = Bundle.main.decode("missions.json")
    
    
    var body:some View{
        NavigationView {
            ScrollView {
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
                .padding([.horizontal,.vertical])
            }
            .navigationTitle("MoonShot")
            .preferredColorScheme(.dark)
            .background(.darkBackground)
        }

    }
    
}
//ShapeStyleはbackground()で使うもの。
//Colorの拡張だがbackgroundでも使えるようにShapeStyleの拡張として使う
extension ShapeStyle where Self == Color{
    static var darkBackground:Color{
        Color(red:0.1,green: 0.1,blue: 0.2)
    }
    static var lightBackgrounc:Color{
        Color(red:0.2,green: 0.2,blue: 0.3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
