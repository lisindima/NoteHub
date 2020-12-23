//
//  SideBar.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 20.12.2020.
//

import SwiftUI

struct SideBar: View {
    @State private var selection: NavigationItem? = .note
    @State private var openSettings: Bool = false
    
    var sidebar: some View {
        List(selection: $selection) {
            Section(header: Text("general")) {
                NavigationLink(destination: NoteList()) {
                    Label("notes", systemImage: "note")
                }
                .tag(NavigationItem.note)
                NavigationLink(destination: TrashList()) {
                    Label("trash", systemImage: "trash")
                }
                .tag(NavigationItem.trash)
            }
            Section(header: Text("tags")) {
                Label("Тег", systemImage: "tag")
                Label("Тег", systemImage: "tag")
                Label("Тег", systemImage: "tag")
                Label("Тег", systemImage: "tag")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("NoteHub")
    }
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            sidebar
                .frame(width: 180)
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
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {}) {
                            Label("Add Item", systemImage: "plus")
                        }
                        .help("Беебебебебеб")
                    }
                }
        }
    }
}

enum NavigationItem {
    case note
    case trash
    case settings
}
