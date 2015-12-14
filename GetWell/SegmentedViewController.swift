//
//  SegmentedViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/14/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import AVFoundation

@objc protocol MediaPlayerViewDelegate
{
    func timerWasChosen(timerCount: Int)
    
}

class SegmentedViewController: UIViewController,MediaPlayerViewDelegate
{
    
    var timer: NSTimer?
    var originalCount = 120
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowCountdownSegue"
        {
            let mediaPlayerVC = segue.destinationViewController as! MediaPlayerViewController
            mediaPlayerVC.delegate = self
        }
    }
    
    func timerWasChosen(timerCount: Int)
    {
        originalCount = timerCount
    }
 
}
