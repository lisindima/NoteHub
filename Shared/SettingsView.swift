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
    
    var versionApp: Text {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        return Text("\(version) (\(build))")
    }
    
    var body: some View {
        Form {
            Section(header: Text("Подписка")) {
                LabelButton("Обновление до NoteHub Plus", systemName: "plus.app.fill") {
                    openSubscriptionView = true
                }
            }
            NavigationLink(destination: CustomizationView()) {
                Label("Кастомизация", systemImage: "paintbrush")
            }
            Section(footer: versionApp) {
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
    
    var body: some View {
        Form {
            Section(footer: Text("Меняет цветовой акцент во всем приложение.")) {
                ColorPicker(selection: $settingsStore.accentColor, supportsOpacity: true) {
                    Label("Цветовой акцент", systemImage: "paintbrush")
                }
            }
        }
        .navigationTitle("Кастомизация")
    }
}
