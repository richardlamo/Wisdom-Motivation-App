//
//  Wisdom_Motivation_AppApp.swift
//  Wisdom Motivation App
//
//  Created by Richard Lam on 11/5/2022.
//

import SwiftUI

@main
struct Wisdom_Motivation_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
