//
//  FilteredList.swift
//  Project12CoreData2
//
//  Created by 野中淳 on 2023/01/13.
//

import SwiftUI

struct FilteredList: View {
    
    @FetchRequest var fetchResult:FetchedResults<Singer>
    
    
    var body: some View{
        List(fetchResult,id:\.self){singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter:String){
        _fetchResult = FetchRequest<Singer>(sortDescriptors: [],predicate: NSPredicate(format: "lastName BEGINSWITH %@",filter))
    }
    
}
