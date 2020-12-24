//
//  NoteHubApp.swift
//  Shared
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import SwiftUI

@main
struct NoteHubApp: App {
    @StateObject private var settingsStore = SettingsStore.shared
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .accentColor(settingsStore.accentColor)
                .environmentObject(settingsStore)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .commands {
            SidebarCommands()
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
