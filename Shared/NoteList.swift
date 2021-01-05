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
        predicate: NSPredicate(format: "isDelete == NO"),
        animation: .default
    )
    private var notes: FetchedResults<Note>
    
    private func deleteNote(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let note = notes[index]
                note.isDelete = true
                note.isPin = false
            }
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
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
                    Menu {
                        Section {
                            Button(action: {}) {
                                Label("Сортировка", systemImage: "pin")
                            }
                            Button(action: {}) {
                                Label("Сортировка", systemImage: "trash")
                            }
                        }
                    }
                    label: {
                        Label("Add", systemImage: "ellipsis.circle")
                            .imageScale(.large)
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
        LoadingView(notes, title: "Нет заметок", subTitle: "Что то еще дописать....") { notes in
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
        .navigationTitle("notes")
        .sheet(isPresented: $showCreateNote) {
            CreateNote()
                .accentColor(.purple)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NoteList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
