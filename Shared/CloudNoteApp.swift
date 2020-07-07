//
//  CloudNoteApp.swift
//  Shared
//
//  Created by Дмитрий Лисин on 07.07.2020.
//

import SwiftUI

@main
struct CloudNoteApp: App {
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            if horizontalSizeClass == .compact {
                TasksView()
            } else {
                ContentView()
            }
            
            #else
            ContentView()
            #endif
        }
    }
}
