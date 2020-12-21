//
//  TabBar.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 21.12.2020.
//

import SwiftUI

struct TabBar: View {
    @State private var selection: NavigationItem? = .note
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                NoteList()
            }
            .tabItem { Label("Заметки", systemImage: "note") }
            .tag(NavigationItem.note)
            NavigationView {
                TrashList()
            }
            .tabItem { Label("Корзина", systemImage: "trash") }
            .tag(NavigationItem.trash)
            NavigationView {
                SettingsView()
            }
            .tabItem { Label("Настройка", systemImage: "gear") }
            .tag(NavigationItem.settings)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
