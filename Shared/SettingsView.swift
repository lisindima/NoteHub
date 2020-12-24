//
//  SettingsView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 20.12.2020.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settingsStore: SettingsStore
    
    var body: some View {
        Form {
            Section(header: Text("Кастомизация")) {
                ColorPicker(selection: $settingsStore.accentColor, supportsOpacity: true) {
                    Label("Цветовой акцент", systemImage: "paintbrush")
                }
            }
        }
        .navigationTitle("settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
