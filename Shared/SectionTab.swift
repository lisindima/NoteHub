//
//  SectionTab.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 07.01.2021.
//

import SwiftUI

struct SectionTab: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createDate, ascending: false)],
        predicate: NSPredicate(format: "isPin == YES"),
        animation: .default
    )
    private var notes: FetchedResults<Note>
    
    var body: some View {
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
}
