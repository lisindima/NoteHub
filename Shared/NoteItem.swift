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
        VStack(alignment: .leading) {
            Text(note.titleNote ?? "")
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
            Text(note.textNote ?? "")
                .font(.caption2)
                .lineLimit(2)
            Text(note.createDate ?? Date(), style: .relative)
                .font(.caption2)
        }
    }
}

struct NoteItem_Previews: PreviewProvider {
    static var previews: some View {
        NoteItem(note: Note())
    }
}
