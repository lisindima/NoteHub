//
//  SideBar.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 20.12.2020.
//

import SwiftUI

struct SideBar: View {
    @State private var openSettings: Bool = false
    
    #if os(macOS)
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    #endif
    
    var sidebar: some View {
        List {
            SectionTab()
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("NoteHub")
    }
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            sidebar
                .frame(width: 180)
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Button(action: toggleSidebar) {
                            Image(systemName: "sidebar.left")
                        }
                    }
                }
            #else
            sidebar
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: { openSettings = true }) {
                            Image(systemName: "gear")
                                .imageScale(.large)
                        }
                    }
                }
                .sheet(isPresented: $openSettings) {
                    NavigationView {
                        SettingsView()
                            .toolbar {
                                ToolbarItem(placement: .primaryAction) {
                                    Button(action: { openSettings = false }) {
                                        Text("close")
                                    }
                                }
                            }
                    }
                }
            #endif
            
            Text("sidebar_title_select_menu")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Text("sidebar_title_select_note")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

enum NavigationItem {
    case note
    case trash
    case settings
}
