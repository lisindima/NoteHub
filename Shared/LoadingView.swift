//
//  LoadingView.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 02.01.2021.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    var notes: FetchedResults<Note>
    var title: String = ""
    var subTitle: String = ""
    var content: (_ notes: FetchedResults<Note>) -> Content
    
    init(_ notes: FetchedResults<Note>, title: String, subTitle: String, content: @escaping (_ notes: FetchedResults<Note>) -> Content) {
        self.notes = notes
        self.title = title
        self.subTitle = subTitle
        self.content = content
    }
    
    var body: some View {
        if notes.isEmpty {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text(subTitle)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        } else {
            content(notes)
        }
    }
}
