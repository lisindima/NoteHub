//
//  TrashList.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

import SwiftUI

struct TrashList: View {
    @Environment(\.managedObjectContext) private var moc
    
    @State private var searchText: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createDate, ascending: false)],
        predicate: NSPredicate(format: "isDelete == YES"),
        animation: .default
    )
    private var notes: FetchedResults<Note>
    
    private func deleteNote(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(moc.delete)
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        LoadingView(notes, title: "Корзина пуста", subTitle: "Что то еще дописать....") { notes in
            List {
                ForEach(notes.filter {
                    searchText.isEmpty || $0.textNote.localizedStandardContains(searchText)
                }, id: \.id) { note in
                    NavigationLink(destination: NoteDetails(note: note)) {
                        NoteItem(note: note)
                    }
                }
                .onDelete(perform: deleteNote)
            }
            .modifier(ListStyle())
            .navigationSearchBar("Поиск заметок", searchText: $searchText)
        }
        .navigationTitle("trash")
    }
}

struct TrashList_Previews: PreviewProvider {
    static var previews: some View {
        TrashList()
    }
}
