//
//  Note+CoreDataProperties.swift
//  NoteHub (iOS)
//
//  Created by Дмитрий Лисин on 05.01.2021.
//
//

import CoreData
import Foundation

public extension Note {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Note> {
        NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged var changeDate: Date
    @NSManaged var createDate: Date
    @NSManaged var id: UUID
    @NSManaged var isDelete: Bool
    @NSManaged var isPin: Bool
    @NSManaged var textNote: String
}

extension Note: Identifiable {}
