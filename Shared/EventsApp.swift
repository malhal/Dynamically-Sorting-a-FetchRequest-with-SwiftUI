//
//  EventsApp.swift
//  Shared
//
//  Created by Malcolm Hall on 24/06/2021.
//

import SwiftUI

@main
struct EventsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
