//
//  NoteList.swift
//  Shared
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import CoreData
import NativeSearchBar
import SwiftUI

struct NoteList: View {
    @Environment(\.managedObjectContext) private var moc
    
    @State private var searchText: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createDate, ascending: false)],
        predicate: NSPredicate(format: "isDelete == NO"),
        animation: .default
    )
    private var notes: FetchedResults<Note>
    
    private func deleteNote(offsets: IndexSet) {
        withAnimation {
            let note = notes[offsets.first!]
            note.isDelete = true
            note.isPin = false
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        LoadingView(notes, title: "Нет заметок", subTitle: "Что то еще дописать....") { notes in
            List {
                ForEach(
                    notes.filter { searchText.isEmpty || $0.textNote!.localizedStandardContains(searchText) },
                    content: NoteItem.init
                )
                .onDelete(perform: deleteNote)
            }
            .modifier(ListStyle())
            .navigationSearchBar("Поиск заметок", searchText: $searchText)
        }
        .navigationTitle("notes")
        .toolbar {
            #if !os(watchOS)
            ToolbarItem(placement: .primaryAction) {
                NavigationLink(destination: CreateNote()) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
                .help("Создать новую заметку")
            }
            #endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
