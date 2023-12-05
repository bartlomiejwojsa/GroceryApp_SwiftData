//
//  PhotoModel.swift
//  GroceryApp_SwiftData
//
//  Created by Bartłomiej Wojsa on 05/12/2023.
//

import Foundation

struct GetPhotosResponse: Codable {
    let photos: [PhotoResponse]
}

struct PhotoResponse: Codable {
    let src: PhotoSources
}

struct PhotoSources: Codable {
    let original: String?
    let large2x: String?
    let large: String?
    let medium: String?
    let tiny: String?
}
