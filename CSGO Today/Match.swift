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
    var team1Id : Int!
    var team2Id : Int!
    var team1Score : Int
    var team2Score : Int
    var startDate : NSDate!
    
    init(dictionary : Dictionary<String, AnyObject>) {
        name = dictionary["competition_label"] as! String
        team1Score = dictionary["team1_score"] as! Int;
        team2Score = dictionary["team2_score"] as! Int;
        
        print(dictionary)
    }
}