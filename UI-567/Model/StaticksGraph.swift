//
//  StaticksGraph.swift
//  UI-567
//
//  Created by nyannyan0328 on 2022/05/23.
//

import SwiftUI

struct StaticksGraph: Identifiable {
    var id = UUID().uuidString
    var monthString : String
    var monthData : Date
    var expece : [Expense]
    
}

