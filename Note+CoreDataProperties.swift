//
//  Note+CoreDataProperties.swift
//  Trainer
//
//  Created by Yury Bikuzin on 08.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation
import CoreData

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var added: Date?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var recordID: Data?
    @NSManaged public var recordName: String?
    @NSManaged public var text: String?
    @NSManaged public var user: User?

}
