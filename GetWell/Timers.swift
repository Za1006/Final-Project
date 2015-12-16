//
//  Timers.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/15/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Timer
{
    let fiveMinutesCount: Int
    let tenMinutesCount: Int
    let fifteenMinutesCount: Int
    let twentyMinutesCount: Int
    
    init(fiveMinutesCount: Int, tenMinutesCount: Int, fifteenMinutesCount: Int, twentyMinutesCount: Int)
    {
        self.fiveMinutesCount = 300
        self.tenMinutesCount = 600
        self.fifteenMinutesCount = 900
        self.twentyMinutesCount = 1200
    }
    
}