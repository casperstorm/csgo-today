//
//  API.swift
//  CSGO Today
//
//  Created by Peter Gammelgaard on 19/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Foundation

struct Content {
    var matches : Array<Match>
    var teams : Array<Team>

    init(dictionary: Dictionary<String, AnyObject>) {
        let matchDictionaries = dictionary["matches"] as! Array<Dictionary<String, AnyObject>>
        let teamsDictionaries = dictionary["teams"] as! Array<Dictionary<String, AnyObject>>

        self.matches = matchDictionaries.map {
            let team1Id = $0["team1_id"] as! Int
            let team2Id = $0["team2_id"] as! Int

            var team1 : Team?
            for dict in teamsDictionaries {
                if (dict["id"] as! Int == team1Id) {
                    team1 = Team(dictionary: dict)
                }
            }

            var team2 : Team?
            for dict in teamsDictionaries {
                if (dict["id"] as! Int == team2Id) {
                    team2 = Team(dictionary: dict)
                }
            }

            return Match(dictionary: $0, team1: team1!, team2: team2!)
        }
        self.teams = teamsDictionaries.map {
            Team(dictionary: $0)
        }
    }
}

class API {
    class func fetchContentWithDate(date: NSDate, callback: (Content!, NSError!) -> Void) {
        let midnight = date.dateAtMidnight()
        let session = NSURLSession.sharedSession()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let nextDate = midnight.dateByAddingTimeInterval(60*60*24)
        let urlString = "https://esports-api.thescore.com/csgo/matches?start_date_from=\(dateFormatter.stringFromDate(midnight))&start_date_to=\(dateFormatter.stringFromDate(nextDate))"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if error != nil {
                    callback(nil, error)
                } else if let d = data {
                    do {
                        let dictionary = try NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.AllowFragments) as! Dictionary<String, AnyObject>
                        let content = Content(dictionary: dictionary)
                        callback(content, nil)
                    } catch let err as NSError {
                        callback(nil, err)
                    } catch {
                        callback(nil, nil)
                    }
                } else {
                    callback(nil, nil)
                }
            })
        }
    
        task!.resume()
    }
}