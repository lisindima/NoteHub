//
//  NoteDetails.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

import SwiftUI

struct NoteDetails: View {
    var note: Note
    
    var body: some View {
        Text(note.textNote!)
    }
}

struct NoteDetails_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetails(note: Note())
    }
}
