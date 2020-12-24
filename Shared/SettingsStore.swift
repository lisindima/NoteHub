//
//  SettingsStore.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 24.12.2020.
//

import SwiftUI

class SettingsStore: ObservableObject {
    @Published var accentColor: Color = .purple
    
    static let shared = SettingsStore()
}
