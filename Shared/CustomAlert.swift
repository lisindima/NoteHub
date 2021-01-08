//
//  CustomAlert.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 08.01.2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var action: (() -> Void)? = {}
}

struct CustomAlert: ViewModifier {
    @Binding var item: AlertItem?
    
    func body(content: Content) -> some View {
        content
            .alert(item: $item) { item in
                alert(title: item.title, message: item.message, action: item.action)
            }
    }
}

extension ViewModifier {
    func alert(title: String, message: String, action: (() -> Void)? = {}) -> Alert {
        Alert(
            title: Text(title),
            message: Text(message),
            dismissButton: .cancel(Text("Закрыть"), action: action)
        )
    }
}

extension View {
    func customAlert(item: Binding<AlertItem?>) -> some View {
        modifier(CustomAlert(item: item))
    }
}
