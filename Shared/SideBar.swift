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
            Section(header: Text("Главное")) {
                NavigationLink(destination: NoteList()) {
                    Label("Заметки", systemImage: "note")
                }
                .tag(NavigationItem.note)
                NavigationLink(destination: TrashList()) {
                    Label("Корзина", systemImage: "trash")
                }
                .tag(NavigationItem.trash)
            }
            Section(header: Text("Теги")) {
                Label("Тег", systemImage: "tag")
                Label("Тег", systemImage: "tag")
                Label("Тег", systemImage: "tag")
                Label("Тег", systemImage: "tag")
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Главная")
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
                                        Text("Закрыть")
                                    }
                                }
                            }
                    }
                }
            #endif
            
            Text("Выберите\nпункт в меню")
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Text("Выберите заметку\nдля просмотра")
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
