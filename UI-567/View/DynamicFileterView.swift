//
//  DynamicFileterView.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI
import CoreData

struct DynamicFileterView<Content : View,T>: View  where T : NSManagedObject{
    
    
    @FetchRequest var request : FetchedResults<T>
    
    let content : (FetchedResults<T>)->Content
    
    
    
    init(startDate : Date,endDate : Date,type : String,@ViewBuilder content : @escaping(FetchedResults<T>) -> Content) {
        
        
        let fileterKey = "date"
        var predicate : NSPredicate!
        
        if type == "ALL"{
            
            predicate = NSPredicate(format: "\(fileterKey) >= %@ AND \(fileterKey) < %@", argumentArray: [startDate,endDate])
            
            
            
        }
        
        else{
            predicate = NSPredicate(format: "\(fileterKey) >= %@ AND \(fileterKey) < %@ AND type == %@", argumentArray: [startDate,endDate])
            
            
            
        }
        
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Expense.date, ascending: false)],predicate: type == "NONE" ? nil:predicate,animation: .easeInOut)
        
        self.content = content
    }
    

    
    
    var body: some View {
      content(request)
    }
}

