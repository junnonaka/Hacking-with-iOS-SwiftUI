//
//  BookWormApp.swift
//  BookWorm
//
//  Created by 野中淳 on 2023/01/09.
//

import SwiftUI

@main
struct BookWormApp: App {

    @StateObject private var dataContoller = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,dataContoller.container.viewContext)
        }
    }
}
