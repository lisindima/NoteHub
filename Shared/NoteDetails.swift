//
//  NoteDetails.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 18.12.2020.
//

import SwiftUI
import SwiftDown

struct NoteDetails: View {
    @Environment(\.managedObjectContext) private var moc
//    @Environment(\.presentationMode) private var presentationMode
//    Пропадает кнопка "Назад"
    
    @State private var textNote: String = ""
    @State private var isPin: Bool = false
    @State private var isDelete: Bool = false
    
    var note: Note
    
    init(note: Note) {
        self.note = note
        _textNote = State<String>(initialValue: note.textNote ?? "")
        _isPin = State<Bool>(initialValue: note.isPin)
        _isDelete = State<Bool>(initialValue: note.isDelete)
    }
    
    private func saveNote() {
        if textNote != note.textNote {
            note.changeDate = Date()
            note.textNote = textNote
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                print("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteOrRestoreNote(_ value: Bool) {
        isDelete = value
        note.isDelete = value
        note.isPin = false
        do {
            try moc.save()
//            presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func setPin(_ value: Bool) {
        isPin = value
        note.isPin = value
        do {
            try moc.save()
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        SwiftDownEditor(text: $textNote)
            .onDisappear(perform: saveNote)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Menu {
                        Section {
                            Button(action: { setPin(isPin ? false : true) }) {
                                Label(
                                    isPin ? "Открепить" : "Закрепить",
                                    systemImage: isPin ? "pin.slash" : "pin"
                                )
                            }
                            Button(action: { deleteOrRestoreNote(isDelete ? false : true) }) {
                                Label(
                                    isDelete ? "Восстановить заметку" : "Удалить заметку",
                                    systemImage: isDelete ? "trash.slash" : "trash"
                                )
                            }
                        }
                    }
                    label: {
                        Label("Add", systemImage: "ellipsis.circle")
                            .imageScale(.large)
                    }
                }
            }
            .modifier(NavigationTitleStyle())
    }
}
