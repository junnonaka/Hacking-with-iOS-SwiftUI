//
//  Project12CoreDataApp.swift
//  Project12CoreData
//
//  Created by 野中淳 on 2023/01/12.
//

import SwiftUI

@main
struct Project12CoreDataApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
