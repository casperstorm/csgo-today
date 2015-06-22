//
//  Extensions.swift
//  CSGO Today
//
//  Created by Peter Gammelgaard on 22/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Foundation
import AppKit
import ImageIO


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

extension NSImage {
    class func imageFromURL(url : NSURL) -> NSImage? {
        let imageData = NSData(contentsOfURL: url)
        if let imageData = imageData {
            return NSImage(data: imageData)
        }
        
        return nil
    }
    
    func imageByScalingToSize(size : CGSize) -> NSImage {
        let img = NSImage(size: size)
        
        img.lockFocus()
        let ctx = NSGraphicsContext.currentContext()
        ctx?.imageInterpolation = .High
        self.drawInRect(NSMakeRect(0, 0, size.width, size.height), fromRect: NSMakeRect(0, 0, self.size.width, self.size.height), operation: .CompositeCopy, fraction: 1)
        img.unlockFocus()
        
        return img
    }
}