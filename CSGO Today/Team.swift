//
//  Team.swift
//  CSGO Today
//
//  Created by Peter Gammelgaard on 19/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Foundation

struct TeamLogo {
    enum Size : String {
        case ExtraSmall = "w20xh20"
        case Small = "w38xh38"
        case Medium = "w72xh72"
        case Large = "w128xh128"
        case ExtraLarge = "w256xh256"
    }
    
    let size : Size
    let url : NSURL
    
    init(dictionary : Dictionary<String, AnyObject>) {
        self.url = NSURL(string: dictionary["url"] as! String)!
        self.size = Size(rawValue: dictionary["size"] as! String)!
    }
}

class Team : NSObject {
    let id : Int
    let name : String
    let shortName : String
    let country : String
    let logos : Array<TeamLogo>
    let alternativeLogos : Array<TeamLogo>
    
    init(dictionary: Dictionary<String, AnyObject>) {
        self.id = dictionary["id"] as! Int
        self.name = dictionary["full_name"] as! String
        self.shortName = dictionary["short_name"] as! String
        
        let country = dictionary["country"]
        if (country!.isKindOfClass(NSNull)) {
            self.country = ""
        } else {
            self.country = dictionary["country"] as! String
        }
        
        let logos = dictionary["logo"] as! Array<Dictionary<String, AnyObject>>
        
        self.logos = logos.map {
            let key = $0.keys.first as String!
            let url : String = $0[key] as! String
            let dict : Dictionary<String, AnyObject> = ["url" : url, "size" : key]
        
            return TeamLogo(dictionary: dict)
        }
        
        let alternativeLogos = dictionary["alternate_logo"] as! Array<Dictionary<String, AnyObject>>
        
        self.alternativeLogos = alternativeLogos.map {
            let key = $0.keys.first as String!
            let url : String = $0[key] as! String
            let dict : Dictionary<String, AnyObject> = ["url" : url, "size" : key]
            
            return TeamLogo(dictionary: dict)
        }
    }
}
