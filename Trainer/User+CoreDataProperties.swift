//
//  User+CoreDataProperties.swift
//  Trainer
//
//  Created by Yury Bikuzin on 18.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation
import CoreData
import 

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var added: NSDate?
    @NSManaged public var lastUpdate: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var recordID: NSData?
    @NSManaged public var recordName: String?
    @NSManaged public var notes: NSSet?

}

// MARK: Generated accessors for notes
extension User {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}
