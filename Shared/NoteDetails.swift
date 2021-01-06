//
//  NoteDetails.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

#if !os(watchOS)
import HighlightedTextEditor
#endif
import SwiftUI

struct NoteDetails: View {
    @Environment(\.managedObjectContext) private var moc
    
    @State private var textNote: String = ""
    @State private var isPin: Bool = false
    
    var note: Note
    
    init(note: Note) {
        self.note = note
        _textNote = State<String>(initialValue: note.textNote)
        _isPin = State<Bool>(initialValue: note.isPin)
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
    
    private func setPin(_ value: Bool) {
        note.isPin = value
        do {
            try moc.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        #if !os(watchOS)
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
                            Button(action: { setPin(note.isPin ? false : true) }) {
                                Label(isPin ? "Открепить" : "Закрепить", systemImage: isPin ? "pin.slash" : "pin")
                            }
                            Button(action: {}) {
                                Label("Удалить заметку", systemImage: "trash")
                            }
                        }
                    }
                    label: {
                        Label("Add", systemImage: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
            }
            .modifier(NavigationTitleStyle())
        #endif
    }
}
