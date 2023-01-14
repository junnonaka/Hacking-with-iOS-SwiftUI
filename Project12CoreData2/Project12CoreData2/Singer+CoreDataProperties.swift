//
//  Singer+CoreDataProperties.swift
//  Project12CoreData2
//
//  Created by 野中淳 on 2023/01/13.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    var wrappedFirstName:String{
        firstName ?? "Unknown"
    }
    
    var wrappedLastName:String{
        lastName ?? "Unknown"
    }

}

extension Singer : Identifiable {

}
