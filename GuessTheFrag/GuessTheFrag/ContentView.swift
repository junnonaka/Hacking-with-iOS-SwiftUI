//
//  ContentView.swift
//  GuessTheFrag
//
//  Created by 野中淳 on 2022/11/11.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctFrag = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    
    @State private var animationAmount = 0.0
    
    @State private var tapButton = 0
    
    @State private var opacity = 1.0
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color:.blue,location:0.3),
                .init(color:.red,location:0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing:15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                            withAnimation {
                                animationAmount += 360
                                opacity = 0.25
                            }
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(Angle(degrees: number == tapButton ? animationAmount : 0), axis: (x:0,y:1,z:0))
                        .opacity(number != tapButton ? opacity : 1)
                        
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius:20))
                Spacer()
                Text("Score:\(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button {
                askQuestion()
                opacity = 1
            } label: {
                Text("Continue")
            }
        }message:{
            Text("Your score is \(score). \(correctFrag) ")
        }
    }
    
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
            correctFrag = ""
        }else{
            scoreTitle = "Wrong"
            score -= 1
            correctFrag = "this is \(countries[correctAnswer])'s frag"
            
        }
        print("tup Num \(number)")
        tapButton = number
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
