//
//  NoteHubApp.swift
//  Shared
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import SwiftUI
import Purchases

@main
struct NoteHubApp: App {
    @StateObject private var settingsStore = SettingsStore.shared
    @AppStorage(CustomColorScheme.defaultKey) var customColorScheme = CustomColorScheme.defaultValue
    
    let persistenceController = PersistenceController.shared
    
    init() {
        Purchases.debugLogsEnabled = true
        Purchases.configure(withAPIKey: "KqxRlxVJObhJFLWuNPVVPZzhckgXHjtZ")
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .accentColor(settingsStore.accentColor)
                .customColorScheme($customColorScheme)
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
