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
        
        self.team1ImageView.imageScaling = .ScaleProportionallyDown;
        self.team2ImageView.imageScaling = .ScaleProportionallyDown;

    }
    
    override var representedObject: AnyObject? {
        didSet {
            self.team1ImageView.image = nil
            self.team2ImageView.image = nil

            let match = representedObject as! Match
            let team1 = match.team1
            let team2 = match.team2
            
            let nowDate = NSDate()

            let matchIsInFuture = match.startDate.isEarlierThan(nowDate)
            
            self.timeTextField.hidden = matchIsInFuture
            self.timeTextField.stringValue = match.formattedTime
            
            let team1Logo = team1.logoOfSize(.Small)
            if let team1Logo = team1Logo {
                ImageDownloader.imageFromURL(team1Logo.url) {
                    self.team1ImageView.image = $0?.imageByScalingToSize(CGSizeMake(20, 20))
                }
            }
            
            let team2Logo = team2.logoOfSize(.Small)
            if let team2Logo = team2Logo {
                ImageDownloader.imageFromURL(team2Logo.url) {
                    self.team2ImageView.image = $0?.imageByScalingToSize(CGSizeMake(20, 20))
                }

            }
            self.team1NameTextField.stringValue = team1.name
            self.team2NameTextField.stringValue = team2.name
            
            self.team1ScoreTextField.hidden = !matchIsInFuture
            self.team2ScoreTextField.hidden = !matchIsInFuture
            self.team1ScoreTextField.stringValue = String(match.team1Score)
            self.team2ScoreTextField.stringValue = String(match.team2Score)
        }
    }

}
