//
//  Movie+CoreDataProperties.swift
//  Project12CoreData
//
//  Created by 野中淳 on 2023/01/13.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var director: String?
    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    
    public var wrappedTitle:String{
        title ?? "Unknown Title"
    }

}

extension Movie : Identifiable {

}
