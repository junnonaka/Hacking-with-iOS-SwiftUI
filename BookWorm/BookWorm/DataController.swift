//
//  DataController.swift
//  BookWorm
//
//  Created by 野中淳 on 2023/01/10.
//
import CoreData
import Foundation

class DataController:ObservableObject{
    //CoreDataをロードする準備
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        //CoreDataへのアクセス：この時点では読み出していない
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
