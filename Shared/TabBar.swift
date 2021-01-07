//
//  TabBar.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 21.12.2020.
//

import SwiftUI

struct TabBar: View {
    @State private var openSettings: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                SectionTab()
            }
            .modifier(ListStyle())
            .navigationTitle("NoteHub")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { openSettings = true }) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $openSettings) {
                NavigationView {
                    SettingsView()
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: { openSettings = false }) {
                                    Text("close")
                                }
                            }
                        }
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
