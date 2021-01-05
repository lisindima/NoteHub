//
//  TabBar.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 21.12.2020.
//

import SwiftUI

struct TabBar: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createDate, ascending: false)],
        predicate: NSPredicate(format: "isPin == YES"),
        animation: .default
    )
    private var notes: FetchedResults<Note>
    
    @State private var openSettings: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("general")) {
                    NavigationLink(destination: NoteList()) {
                        Label("notes", systemImage: "note")
                    }
                    NavigationLink(destination: TrashList()) {
                        Label("trash", systemImage: "trash")
                    }
                }
                if !notes.isEmpty {
                    Section(
                        header:
                            HStack {
                                Text("Закрепленные")
                                Spacer()
                                if notes.count >= 4 {
                                    NavigationLink(destination: Text("Закрепленные")) {
                                        Text("Ещё")
                                            .fontWeight(.semibold)
                                    }
                                }
                            },
                        footer:
                            Text("Закрепленные заметки будут отображаться в виджете.")
                    ) {
                        ForEach(notes.prefix(4), id: \.id) { note in
                            NavigationLink(destination: NoteDetails(note: note)) {
                                NoteItem(note: note)
                            }
                        }
                    }
                }
                Section(header: Text("tags")) {
                    Label("Тег", systemImage: "tag")
                    Label("Тег", systemImage: "tag")
                    Label("Тег", systemImage: "tag")
                    Label("Тег", systemImage: "tag")
                }
            }
            .listStyle(InsetGroupedListStyle())
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
