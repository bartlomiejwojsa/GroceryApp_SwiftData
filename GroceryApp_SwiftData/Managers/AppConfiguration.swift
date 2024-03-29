//
//  AppConfiguration.swift
//  Pawted
//
//  Created by Bartłomiej Wojsa on 14/10/2023.
//

import Foundation

class AppConfiguration {
    static let shared = AppConfiguration()

    private let configuration: [String: Any]

    private init() {
        guard let plistURL = Bundle.main.url(forResource: "AppConfig", withExtension: "plist"),
              let data = try? Data(contentsOf: plistURL),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil),
              let plistDict = plist as? [String: Any] else {
            fatalError("Unable to load AppConfig.plist")
        }
        self.configuration = plistDict
    }

    var photoAPIToken: String {
        return configuration["photoAPIToken"] as? String ?? ""
    }
}
