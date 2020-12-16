//
//  NoteHubApp.swift
//  Shared
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import SwiftUI

@main
struct NoteHubApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
