//
//  DeleteCloudKitObject+CoreDataProperties.swift
//  Trainer
//
//  Created by Yury Bikuzin on 08.09.16.
//  Copyright © 2016 Yury Bikuzin. All rights reserved.
//

import Foundation
import CoreData

extension DeleteCloudKitObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DeleteCloudKitObject> {
        return NSFetchRequest<DeleteCloudKitObject>(entityName: "DeleteCloudKitObject");
    }

    @NSManaged public var recordID: Data?
    @NSManaged public var recordType: String?

}
