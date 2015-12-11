//
//  MainViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
@objc protocol MediaPlayerViewDelegate
{
    func timerWasChosen(timerCount: Int)

}

class MainViewController: UIViewController, MediaPlayerViewDelegate
{
    
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var TimerSegmentedControl: UISegmentedControl!
    
    
    var delegate: MediaPlayerViewController?
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
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//       if segue.identifier == "ShowMediaCountdownSegue"
//       {
//        let mediaPlayerVC = segue.destinationViewController as!MediaPlayerViewController
//        mediaPlayerVC.delegate = self
//        }
//    }
//  
    
    
    func timerWasChosen(timerCount: Int)
    {
        
    }
    
//    set timer,music will start, and "beep beep" sound will happend when time is up!
    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        
    }
    
    
    @IBAction func setReminderTapped(sender: UIBarButtonItem)
    {
        
    }
    

}
