//
//  CustomColorScheme.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 17.01.2021.
//

import SwiftUI

enum CustomColorScheme: Int, CaseIterable, Identifiable, Codable {
    static var defaultKey = "customColorScheme"
    static var defaultValue = CustomColorScheme.system
    
    case system = 0
    case light = 1
    case dark = 2
    
    var id: Int {
        rawValue
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var label: String {
        switch self {
        case .system:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}

struct CustomColorSchemeViewModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var customColorScheme: CustomColorScheme
    
    @State private var tempColorScheme: ColorScheme? = nil
    
    init(_ customColorScheme: Binding<CustomColorScheme>) {
        _customColorScheme = customColorScheme
    }
    
    func getSystemColorScheme() -> ColorScheme {
        UITraitCollection.current.userInterfaceStyle == .light ? .light : .dark
    }
    
    func body(content: Content) -> some View {
        content
            .preferredColorScheme(tempColorScheme ?? customColorScheme.colorScheme)
            .onChange(of: customColorScheme) { value in
                if value == .system {
                    tempColorScheme = getSystemColorScheme()
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                if customColorScheme == .system {
                    let systemColorScheme = getSystemColorScheme()
                    if systemColorScheme != colorScheme {
                        tempColorScheme = systemColorScheme
                    }
                }
            }
            .onChange(of: tempColorScheme) { value in
                if value != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        tempColorScheme = nil
                    }
                }
            }
    }
}

extension View {
    func customColorScheme(_ customColorScheme: Binding<CustomColorScheme>) -> some View {
        modifier(CustomColorSchemeViewModifier(customColorScheme))
    }
}
