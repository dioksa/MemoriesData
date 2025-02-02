//
//  MemoriesDataApp.swift
//  MemoriesData
//
//  Created by Oksana Dionisieva on 16.01.2025.
//

import SwiftUI
import SwiftData

@main
struct MemoriesDataApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Memory.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
