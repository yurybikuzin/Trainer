//
//  Note+CoreDataProperties.swift
//  Trainer
//
//  Created by Yury Bikuzin on 18.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation
import CoreData
import 

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note");
    }

    @NSManaged public var added: NSDate?
    @NSManaged public var lastUpdate: NSDate?
    @NSManaged public var recordID: NSData?
    @NSManaged public var recordName: String?
    @NSManaged public var text: String?
    @NSManaged public var user: User?

}
