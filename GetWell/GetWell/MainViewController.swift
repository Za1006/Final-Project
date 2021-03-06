//
//  MainViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit


@objc protocol DatePickerDelegate
{
    func dateWasChosen(date: NSDate)
}

class MainViewController: UIViewController,UIPopoverPresentationControllerDelegate
{
    
    var delegate: MediaPlayerViewController?

    
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var setReminder: UIBarButtonItem!
    @IBOutlet weak var TimerSegmentedControl: UISegmentedControl!
    
    var remainingCharacters = ["Obi-Wan Kenobi", "Leia Organa", "R2-D2", "Luke Skywalker", "Grand Moff Tarkin", "Darth Vader"]

    
    
//    var timer: NSTimer?

    
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
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "SetReminderSegue"
        {
            let destVC = segue.destinationViewController as! SetReminderPopOverViewController
            destVC.popoverPresentationController?.delegate = self
            let contentHeight = 50.0 * CGFloat(remainingCharacters.count)
            destVC.preferredContentSize = CGSizeMake(400.0, contentHeight)
        }
    }
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
        //can also just type return .None
    }
    
    func dateWasChosen(date: NSDate)
    {
        //        destinationTime.text = dateFormat(date)
    }
    
    func dateFormat(x: NSDate) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd yyyy", options: 0, locale: NSLocale.currentLocale())
        let formattedTime = formatter.stringFromDate(x).uppercaseString
        
        return String(formattedTime)
    }

   
    
//    set timer,music will start, and "beep beep" sound will happend when time is up!
    
    
//    @IBAction func setNotificationTapped(sender: UIBarButtonItem)
//    {
//        
//    }
    
    
    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        
    }

}
