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
        HighlightedTextEditor(text: $textNote, highlightRules: .markdown)
            .padding()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: saveNote) {
                        Text("Сохранить")
                    }
                }
            }
    }
}

struct CreateNote_Previews: PreviewProvider {
    static var previews: some View {
        CreateNote()
    }
}
