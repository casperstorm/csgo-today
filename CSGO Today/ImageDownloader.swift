//
//  ImageDownloader.swift
//  CSGO Today
//
//  Created by Peter Gammelgaard on 22/06/15.
//  Copyright © 2015 Bob. All rights reserved.
//

import Foundation
import AppKit

class ImageDownloader {
    
    private static var cache : Dictionary<NSURL, NSImage> = Dictionary()
    private static let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

    class func imageFromURL(url : NSURL, completion: (NSImage?) -> Void ) {
        let image = self.cache[url]
        if  image != nil {
            return completion(image)
        }
        
        dispatch_async(self.queue) {
            let image = NSImage.imageFromURL(url)
            
            self.cache[url] = image
            dispatch_async(dispatch_get_main_queue()) {
                completion(image)
            }
        }
    }
}