//
//  NoteDetails.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

import SwiftUI
import HighlightedTextEditor

struct NoteDetails: View {
    @Environment(\.managedObjectContext) private var moc
    
    @State private var textNote: String = ""
    
    var note: Note
    
    init(note: Note) {
        self.note = note
        _textNote = State<String>(initialValue: note.textNote)
    }
    
    private func saveNote() {
        
    }
    
    var body: some View {
        HighlightedTextEditor(text: $textNote, highlightRules: .markdown)
            .padding(6)
            .onDisappear(perform: saveNote)
    }
}

struct NoteDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetails(note: Note())
    }
}
