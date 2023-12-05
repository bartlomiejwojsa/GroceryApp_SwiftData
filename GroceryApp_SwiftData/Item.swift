//
//  Item.swift
//  GroceryApp_SwiftData
//
//  Created by Bartłomiej Wojsa on 05/12/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
