//
//  NSDate+Comparison.swift
//  CSGO Today
//
//  Created by Casper Storm Larsen on 20/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Foundation
extension NSDate {
    func isLaterThan(dateToCompare : NSDate) -> Bool {
        var isLater = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isLater = true
        }
        
        return isLater
    }
    
    
    func isEarlierThan(dateToCompare : NSDate) -> Bool {
        var isEarlier = false
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isEarlier = true
        }
        
        return isEarlier
    }
    
    func dateAtMidnight() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let unitFlags = NSCalendarUnit(rawValue: NSCalendarUnit.Year.rawValue | NSCalendarUnit.Month.rawValue | NSCalendarUnit.Day.rawValue)
        let components = calendar.components(unitFlags, fromDate: self)
        return calendar.dateFromComponents(components)!
    }
}