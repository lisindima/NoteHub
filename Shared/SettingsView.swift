//
//  SettingsView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 20.12.2020.
//

import SwiftUI

struct SettingsView: View {
    @State private var openSubscriptionView: Bool = false
    
    private func openAboutApp() {}
    
    var versionApp: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        return "\(version) (\(build))"
    }
    
    var body: some View {
        Form {
            Section(header: Text("Подписка")) {
                LabelButton("Обновление до NoteHub Plus", systemName: "plus.app.fill") {
                    openSubscriptionView = true
                }
            }
            #if !os(watchOS)
            NavigationLink(destination: CustomizationView()) {
                Label("Кастомизация", systemImage: "paintbrush")
            }
            #endif
            Section(footer: Text(versionApp)) {
                LabelButton("О приложении", systemName: "info.circle", action: openAboutApp)
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

struct CustomizationView: View {
    @EnvironmentObject private var settingsStore: SettingsStore
    
    @AppStorage(CustomColorScheme.defaultKey) var customColorScheme = CustomColorScheme.defaultValue
    
    var body: some View {
        Form {
            Section(header: Text("Цветовая схема")) {
                Picker("Цветовая схема", selection: $customColorScheme) {
                    Text("Системная").tag(CustomColorScheme.system)
                    Text("Светлая").tag(CustomColorScheme.light)
                    Text("Темная").tag(CustomColorScheme.dark)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(footer: Text("Меняет цветовой акцент во всем приложение.")) {
                ColorPicker(selection: $settingsStore.accentColor, supportsOpacity: true) {
                    Label("Цветовой акцент", systemImage: "paintbrush")
                }
            }
        }
        .navigationTitle("Кастомизация")
    }
}
