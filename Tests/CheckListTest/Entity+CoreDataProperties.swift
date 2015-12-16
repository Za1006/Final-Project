//
//  Entity+CoreDataProperties.swift
//  ChecklistTest
//
//  Created by Michael Reynolds on 12/16/15.
//  Copyright © 2015 Michael Reynolds. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entity {

    @NSManaged var item: NSNumber?
    @NSManaged var something: String?

}
