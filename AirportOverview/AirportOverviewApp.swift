//
//  AirportOverviewApp.swift
//  AirportOverview
//
//  Created by Osama Mehdi on 25.07.23.
//

import SwiftUI

@main
struct AirportOverviewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
