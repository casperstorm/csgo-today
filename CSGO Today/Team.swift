//
//  Team.swift
//  CSGO Today
//
//  Created by Peter Gammelgaard on 19/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Foundation

class Team {
    let id : Int
    let name : String
    let shortName : String
    let country : String
    
    init(dictionary: Dictionary<String, AnyObject>) {
        self.id = dictionary["id"] as! Int
        self.name = dictionary["full_name"] as! String
        self.shortName = dictionary["short_name"] as! String
        self.country = dictionary["country"] as! String
    }
}
