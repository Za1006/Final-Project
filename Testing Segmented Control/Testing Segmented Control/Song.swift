//
//  Song.swift
//  IronTunes
//
//  Created by Michael Reynolds on 10/21/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation
import AVFoundation

class Song
{
    let title: String
    let artist: String
    let filename: String
    let albumArtworkName: String
    
    let playerItem: AVPlayerItem
    
    init(title: String, artist: String, filename: String, albumArtwork: String)
    {
        self.title = title
        self.artist = artist
        self.filename = filename
        albumArtworkName = albumArtwork
        self.playerItem = AVPlayerItem(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(filename, ofType: "mp3")!))
    }
    
}
