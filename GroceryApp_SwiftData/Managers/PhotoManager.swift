//
//  PhotoManager.swift
//  GroceryApp_SwiftData
//
//  Created by Bartłomiej Wojsa on 06/12/2023.
//

import Foundation

struct PhotoManager {
    static func getPhotoByName(_ name: String, completion: @escaping (GetPhotosResponse?) -> ())  {
        var request = URLRequest(
            url: URL(string: "https://api.pexels.com/v1/search?query=\(name)")!,
            timeoutInterval: 10.0)
        request.setValue(AppConfiguration.shared.photoAPIToken, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            let photosResponseDetails = try? JSONDecoder().decode(GetPhotosResponse.self, from: data)
            DispatchQueue.main.async {
                completion(photosResponseDetails)
            }
        }
        task.resume()
    }
}
