//
//  RootView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import SwiftUI

struct RootView: View {
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    var body: some View {
        NavigationView {
            #if os(macOS)
            SideBar()
            #else
            if horizontalSizeClass == .compact {
                NoteList()
            } else {
                SideBar()
            }
            #endif
        }
    }
}
