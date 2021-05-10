//
//  NoteHubApp.swift
//  Shared
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import Purchases
import SwiftUI

@main
struct NoteHubApp: App {
    @StateObject private var settingsStore = SettingsStore()
    
    let persistenceController = PersistenceController.shared
    
    init() {
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: "KqxRlxVJObhJFLWuNPVVPZzhckgXHjtZ")
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .accentColor(settingsStore.accentColor)
                .environmentObject(settingsStore)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        #if os(macOS)
        Settings {
            SettingsView()
                .environmentObject(settingsStore)
                .frame(width: 400, height: 300)
        }
        #endif
    }
}
