//
//  NoteDetails.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

import HighlightedTextEditor
import SwiftUI

struct NoteDetails: View {
    @Environment(\.managedObjectContext) private var moc
    
    @State private var textNote: String = ""
    
    var note: Note
    
    init(note: Note) {
        self.note = note
        _textNote = State<String>(initialValue: note.textNote)
    }
    
    private func saveNote() {
        note.changeDate = Date()
        note.textNote = textNote
        do {
            try moc.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        HighlightedTextEditor(text: $textNote, highlightRules: .markdown)
            .onDisappear(perform: saveNote)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Section {
                            Text(note.createDate, style: .date)
                            Text(note.changeDate, style: .date)
                        }
                        Section {
                            Button(action: {}) {
                                Label("Закрепить", systemImage: "pin")
                            }
                            Button(action: {}) {
                                Label("Удалить заметку", systemImage: "trash")
                            }
                        }
                    }
                    label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .modifier(NavigationTitleStyle())
    }
}

struct NoteDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetails(note: Note())
    }
}
