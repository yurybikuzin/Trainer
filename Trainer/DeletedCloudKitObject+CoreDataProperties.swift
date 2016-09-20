//
//  DeletedCloudKitObject+CoreDataProperties.swift
//  Trainer
//
//  Created by Yury Bikuzin on 18.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation
import CoreData


extension DeletedCloudKitObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeletedCloudKitObject> {
        return NSFetchRequest<DeletedCloudKitObject>(entityName: "DeletedCloudKitObject");
    }

    @NSManaged public var recordID: NSData?
    @NSManaged public var recordType: String?

}
