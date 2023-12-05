//
//  GroceryApp_SwiftDataApp.swift
//  GroceryApp_SwiftData
//
//  Created by Bartłomiej Wojsa on 05/12/2023.
//

import SwiftUI
import SwiftData

@main
struct GroceryApp_SwiftDataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: GroceryListItem.self)
    }
}

//struct GroceryApp_SwiftDataApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            GroceryListItem.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//        .modelContainer(sharedModelContainer)
//    }
//}
