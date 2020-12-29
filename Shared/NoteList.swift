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
    
    @State private var showCreateNote: Bool = false
    @State private var searchText: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createDate, ascending: false)],
        animation: .default
    )
    private var notes: FetchedResults<Note>
    
    var body: some View {
        #if os(macOS)
        list
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showCreateNote = true }) {
                        Image(systemName: "plus")
                    }
                    .help("Беебебебебеб")
                }
            }
        #else
        list
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    Spacer()
                    Text("Заметок: \(notes.count)")
                        .font(.caption)
                    Spacer()
                    Button(action: { showCreateNote = true }) {
                        Image(systemName: "doc.badge.plus")
                    }
                }
            }
        #endif
    }
    
    var list: some View {
        List {
            ForEach(notes.filter {
                searchText.isEmpty || $0.textNote.localizedStandardContains(searchText)
            }, id: \.id) { note in
                NavigationLink(destination: NoteDetails(note: note)) {
                    NoteItem(note: note)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .modifier(ListStyle())
        .navigationSearchBar("Поиск заметок", searchText: $searchText)
        .navigationTitle("notes")
        .sheet(isPresented: $showCreateNote) {
            CreateNote()
                .accentColor(.purple)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
