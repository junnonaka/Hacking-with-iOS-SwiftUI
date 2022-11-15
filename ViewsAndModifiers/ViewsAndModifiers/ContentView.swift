//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by 野中淳 on 2022/11/14.
//

import SwiftUI


struct Title:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue)
    }
}

struct ContentView: View {
    var body: some View {
        Text("test")
            .modifier(Title())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
