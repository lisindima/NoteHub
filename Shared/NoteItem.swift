//
//  NoteItem.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

import SwiftUI

struct NoteItem: View {
    @ObservedObject var note: Note
    
    var body: some View {
        NavigationLink(destination: NoteDetails(note: note)) {
            VStack(alignment: .leading) {
                if let textNote = note.textNote {
                    Text(textNote)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                }
                if let createDate = note.createDate {
                    Text(createDate, style: .relative)
                        .font(.caption2)
                }
            }
        }
    }
}

struct NoteItem_Previews: PreviewProvider {
    static var previews: some View {
        NoteItem(note: Note())
    }
}
