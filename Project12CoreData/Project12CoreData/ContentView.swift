//
//  ContentView.swift
//  Project12CoreData
//
//  Created by 野中淳 on 2023/01/12.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var wizards:FetchedResults<Wizard>
    
    var body: some View {
        VStack{
            List(wizards,id:\.self){ wizard in
                Text(wizard.name ?? "UnKnown")
                
            }
            
            Button("Add"){
                let wizard = Wizard(contex)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
