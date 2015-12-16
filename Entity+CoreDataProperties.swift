//
//  Entity+CoreDataProperties.swift
//  
//
//  Created by Keron Williams on 12/16/15.
//
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
