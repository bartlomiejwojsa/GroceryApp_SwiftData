//
//  GroceryListItem.swift
//  GroceryApp_SwiftData
//
//  Created by Bartłomiej Wojsa on 05/12/2023.
//

import Foundation
import SwiftData

@Model
class GroceryListItem {
    let title: String
    let subtitle: String
    let photoSources: PhotoSources?
    let date: Date
    
    init(title: String, subtitle: String, date: Date, photoSources: PhotoSources?) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.photoSources = photoSources
    }
}
