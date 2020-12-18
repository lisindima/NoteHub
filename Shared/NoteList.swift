//
//  NoteList.swift
//  Shared
//
//  Created by Дмитрий Лисин on 16.12.2020.
//

import CoreData
import SwiftUI

struct NoteList: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Note.createDate, ascending: true)],
        animation: .default
    )
    private var notes: FetchedResults<Note>

    var body: some View {
        List {
            ForEach(notes) { note in
                NavigationLink(destination: NoteDetails(note: note)) {
                    NoteItem(note: note)
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            Button(action: addItem) {
                Label("Add Item", systemImage: "plus")
            }
        }
        .navigationTitle("Заметки")
    }

    private func addItem() {
        withAnimation {
            let newItem = Note(context: moc)
            newItem.createDate = Date()

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { notes[$0] }.forEach(moc.delete)

            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
