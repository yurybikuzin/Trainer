//
//  User+CoreDataProperties.swift
//  Trainer
//
//  Created by Yury Bikuzin on 08.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var added: Date?
    @NSManaged public var lastUpdate: Date?
    @NSManaged public var name: String?
    @NSManaged public var recordID: Data?
    @NSManaged public var recordName: String?
    @NSManaged public var notes: Note?

}
