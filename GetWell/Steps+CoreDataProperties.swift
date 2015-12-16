//
//  Steps+CoreDataProperties.swift
//  GetWell
//
//  Created by Keron Williams on 12/16/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import CoreData

extension Steps
{
    @NSManaged var isDone: Bool
    @NSManaged var title: String?
    @NSManaged var date: String?
    
}
