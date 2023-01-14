//
//  Project12CoreData2App.swift
//  Project12CoreData2
//
//  Created by 野中淳 on 2023/01/13.
//

import SwiftUI

@main
struct Project12CoreData2App: App {
    
    @StateObject private var datacontroller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
        }
    }
}
