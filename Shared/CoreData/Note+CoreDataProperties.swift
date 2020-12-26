//
//  Note+CoreDataProperties.swift
//  NoteHub
//
//  Created by Дмитрий Лисин on 26.12.2020.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var changeDate: Date
    @NSManaged public var createDate: Date
    @NSManaged public var isDelete: NSNumber
    @NSManaged public var textNote: String

}

extension Note : Identifiable {

}
