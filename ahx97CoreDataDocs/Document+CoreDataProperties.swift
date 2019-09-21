//
//  Document+CoreDataProperties.swift
//  ahx97CoreDataDocs
//
//  Created by Aaron Henry on 9/20/19.
//  Copyright © 2019 Aaron Henry. All rights reserved.
//
//

import Foundation
import CoreData


extension Document {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var rawDate: NSDate?

}
