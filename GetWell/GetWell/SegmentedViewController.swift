//
//  SegmentedViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/13/15.
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


    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    //When click on the timer (5, 10, 15..) it will segue to the MediaPlayerVC
    
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
        
    }
    
  

}
