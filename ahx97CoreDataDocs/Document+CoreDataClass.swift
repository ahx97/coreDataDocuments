//
//  Document+CoreDataClass.swift
//  ahx97CoreDataDocs
//
//  Created by Aaron Henry on 9/20/19.
//  Copyright © 2019 Aaron Henry. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set{
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(title: String, body: String) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext, title != "" else {
            return nil
        }
        
        self.init(entity: Document.entity(), insertInto: managedContext)
        self.title = title
        self.body = body
        self.date = Date(timeIntervalSinceNow: 0)
    }
    
    
}
