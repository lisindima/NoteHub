//
//  NoteList.swift
//  Shared
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import CoreData
import SwiftUI
import NativeSearchBar

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
        List {
            ForEach(notes.filter {
                searchText.isEmpty || $0.textNote!.localizedStandardContains(searchText)
            }) { note in
                NavigationLink(destination: NoteDetails(note: note)) {
                    NoteItem(note: note)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .modifier(ListStyle())
        .navigationSearchBar("Поиск заметок", searchText: $searchText)
        .sheet(isPresented: $showCreateNote) {
            CreateNote()
                .accentColor(.purple)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: { showCreateNote = true }) {
                    Label("Add Item", systemImage: "plus")
                }
                .help("Беебебебебеб")
            }
        }
        .navigationTitle("notes")
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(moc.delete)
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
