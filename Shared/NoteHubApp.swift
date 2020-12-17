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
        #if os(macOS)
        Settings {
            SettingsView()
                .frame(width: 400, height: 300)
        }
        #endif
    }
}
