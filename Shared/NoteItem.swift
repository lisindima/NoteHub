//
//  NoteItem.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

import SwiftUI

struct NoteItem: View {
    var note: Note
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct NoteItem_Previews: PreviewProvider {
    static var previews: some View {
        NoteItem(note: Note())
    }
}
