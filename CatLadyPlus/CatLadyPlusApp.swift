//
//  CatLadyPlusApp.swift
//  CatLadyPlus
//
//  Created by Adelino Faria on 11/07/2024.
//

import SwiftUI
import SwiftData

@main
struct CatLadyPlusApp: App {

    #if DEBUG
    static let isStoredInMemoryOnly = ProcessInfo.processInfo.environment["TESTING"] == "true"
    #else
    static let isStoredInMemoryOnly = false
    #endif

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CatBreedModel.self,
            CatBreedWeightModel.self,
            CatBreedImageModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: isStoredInMemoryOnly)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
        .modelContainer(sharedModelContainer)
    }
}
