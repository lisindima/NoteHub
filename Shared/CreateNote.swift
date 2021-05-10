//
//  CreateNote.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 20.12.2020.
//

import SwiftUI
import SwiftDown

struct CreateNote: View {
    @Environment(\.managedObjectContext) private var moc
    
    @State private var textNote: String = ""
    
    private func saveNote() {
        let note = Note(context: moc)
        note.createDate = Date()
        note.changeDate = Date()
        note.isPin = false
        note.isDelete = false
        note.textNote = textNote
        do {
            try moc.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        SwiftDownEditor(text: $textNote)
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Новая заметка")
            .modifier(NavigationTitleStyle())
            .onDisappear(perform: saveNote)
    }
}
