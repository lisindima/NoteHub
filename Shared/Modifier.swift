//
//  Modifier.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 23.12.2020.
//

import SwiftUI

struct ListStyle: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        #if os(iOS)
        content
            .listStyle(InsetGroupedListStyle())
        #else
        content
        #endif
    }
}
