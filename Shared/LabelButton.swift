//
//  LabelButton.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 17.01.2021.
//

import SwiftUI

struct LabelButton: View {
    var title: String
    var systemName: String
    var action: () -> Void
    
    init(_ title: String, systemName: String, action: @escaping () -> Void) {
        self.title = title
        self.systemName = systemName
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Label(
                title: { Text(title).foregroundColor(.primary) },
                icon: { Image(systemName: systemName) }
            )
        }
    }
}

