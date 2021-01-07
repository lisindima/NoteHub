//
//  SettingsView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 20.12.2020.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var settingsStore: SettingsStore
    
    @State private var openSubscriptionView: Bool = false
    
    private func openAboutApp() {}
    
    var body: some View {
        Form {
            Section {
                Button(action: { openSubscriptionView = true }) {
                    Label("Обновление до NoteHub Plus", systemImage: "plus.app.fill")
                }
                .buttonStyle(PlainButtonStyle())
            }
            #if !os(watchOS)
            Section(header: Text("Кастомизация")) {
                ColorPicker(selection: $settingsStore.accentColor, supportsOpacity: true) {
                    Label("Цветовой акцент", systemImage: "paintbrush")
                }
            }
            #endif
            Section {
                Button(action: openAboutApp) {
                    Label("О приложении", systemImage: "info.circle")
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .navigationTitle("settings")
        .sheet(isPresented: $openSubscriptionView) {
            SubscriptionView()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
