//
//  CreateNote.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 20.12.2020.
//

import SwiftUI
import HighlightedTextEditor

struct CreateNote: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var moc
    
    @State private var textNote: String = ""
    
    private func saveNote() {
        let note = Note(context: moc)
        note.createDate = Date()
        note.changeDate = Date()
        note.isDelete = false
        note.textNote = textNote
        do {
            try moc.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        #if os(macOS)
        note
            .frame(width: 400, height: 500)
        #else
        note
        #endif
    }
    
    var note: some View {
        NavigationView {
            HighlightedTextEditor(text: $textNote, highlightRules: .markdown)
                .padding(6)
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: saveNote) {
                            Text("Сохранить")
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Text("Закрыть")
                        }
                    }
                }
                .navigationTitle("Новая заметка")
        }
    }
}

struct CreateNote_Previews: PreviewProvider {
    static var previews: some View {
        CreateNote()
    }
}