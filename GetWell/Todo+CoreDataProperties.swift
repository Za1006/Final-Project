//
//  Todo+CoreDataProperties.swift
//  GetWell
//
//  Created by Keron Williams on 12/17/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import CoreData

extension Todo
{
    @NSManaged var isDone: Bool
    @NSManaged var title: String?

    
}

