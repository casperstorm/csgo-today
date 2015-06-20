//
//  ListRowViewController.swift
//  CSGO Today
//
//  Created by Peter Gammelgaard on 19/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Cocoa

class ListRowViewController: NSViewController {
    @IBOutlet weak var timeTextField: NSTextField!
    @IBOutlet weak var team1ImageView: NSImageView!
    @IBOutlet weak var team2ImageView: NSImageView!
    @IBOutlet weak var team1NameTextField: NSTextField!
    @IBOutlet weak var team2NameTextField: NSTextField!
    @IBOutlet weak var team1ScoreTextField: NSTextField!
    @IBOutlet weak var team2ScoreTextField: NSTextField!

    override var nibName: String? {
        return "ListRowViewController"
    }

    override func loadView() {
        super.loadView()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            let match = representedObject as! Match
            let nowDate = NSDate()

            self.timeTextField.hidden = match.startDate.isEarlierThan(nowDate)
            self.timeTextField.stringValue = "12:00" //todo
            
            let data = NSData(contentsOfURL:match.imageUrl)
            self.team1ImageView.image = NSImage(data: data!)
            self.team2ImageView.image = NSImage(data: data!)
        
            self.team1NameTextField.stringValue = match.team1.name
            self.team2NameTextField.stringValue = match.team2.name
            
            self.team1ScoreTextField.stringValue = String(match.team1Score)
            self.team2ScoreTextField.stringValue = String(match.team2Score)
        }
    }

}
