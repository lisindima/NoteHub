//
//  Note+CoreDataProperties.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 26.12.2020.
//
//

import CoreData
import Foundation

public extension Note {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Note> {
        NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged var id: UUID
    @NSManaged var changeDate: Date
    @NSManaged var createDate: Date
    @NSManaged var isDelete: NSNumber
    @NSManaged var textNote: String
}

extension Note: Identifiable {}
