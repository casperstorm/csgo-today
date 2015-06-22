//
//  Match.swift
//  CSGO Today
//
//  Created by Peter Gammelgaard on 19/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Foundation

class Match : NSObject {
    var name : String
    var team1 : Team
    var team2 : Team
    var team1Score : Int
    var team2Score : Int
    var startDate : NSDate
    var formattedTime : String {
        get {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.stringFromDate(self.startDate)
        }
    }
    
    init(dictionary : Dictionary<String, AnyObject>, team1: Team, team2: Team) {
        self.name = dictionary["competition_label"] as! String
        self.team1Score = dictionary["team1_score"] as! Int
        self.team2Score = dictionary["team2_score"] as! Int
        self.team1 = team1
        self.team2 = team2
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateString = dictionary["start_date"] as! String
        
        self.startDate = dateFormatter.dateFromString(dateString)!
    }
    
    
}