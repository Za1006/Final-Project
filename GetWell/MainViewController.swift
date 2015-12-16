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

@objc protocol StepsListViewDelegate
{
    func stepsChecked(buttonTapped: Int)
}
@objc protocol MediaPlayerViewDelegate
{
    func timerWasChosen(timerCount: Int)
}


class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate, DatePickerDelegate, StepsListViewDelegate,MediaPlayerViewDelegate
{
    
    
    var delegate: MediaPlayerViewController?
    var originalCount = 120
    var timer: NSTimer?
    
    
    @IBOutlet weak var nextMeditation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var TimeSegmentedControl: UISegmentedControl!
    
    var remainingCharacters = ["Obi-Wan Kenobi", "Leia Organa", "R2-D2", "Luke Skywalker", "Grand Moff Tarkin", "Darth Vader"]

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
        if segue.identifier == "ShowCountdownSegue"
        {
            let mediaPlayerVC = segue.destinationViewController as! MediaPlayerViewController
            mediaPlayerVC.delegate = self
        }

        if segue.identifier == "SetReminderSegue"
        {
            let destVC = segue.destinationViewController as! SetReminderPopOverViewController
                destVC.popoverPresentationController?.delegate = self
            let contentHeight = 50.0 * CGFloat(remainingCharacters.count)
                destVC.preferredContentSize = CGSizeMake(400.0, contentHeight)
        }
    }
    
    // MARK: - UIPopoverPresentationController Delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
        //can also just type return .None
    }
    
//    Timer chosen from Segmented (5, 10, 15, 20)
    func timerWasChosen(timerCount: Int)
    {
        originalCount = timerCount
    }
    
    // MARK: DatePicker Delegate
    
    func dateWasChosen(date: NSDate)
    {
        nextMeditation.text = dateFormat(date)
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        print(NSDate())
        print(localNotification.fireDate)
        localNotification.timeZone = NSTimeZone.localTimeZone()
        localNotification.alertBody = "Time to Relax"
        localNotification.alertAction = "Open App"
        localNotification.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }


   
    
    func dateFormat(x: NSDate) -> String
    {
        let formatter = NSDateFormatter()
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd yyyy", options: 0, locale: NSLocale.currentLocale())
        let formattedTime = formatter.stringFromDate(x).uppercaseString
        
        return String(formattedTime)
    }
    
    func stepsChecked(buttonTapped: Int)
    {
        
    }
    

    
    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        
        TimeSegmentedControl.addTarget(self, action: "action:", forControlEvents: .TouchUpInside)

        if sender.selectedSegmentIndex == 0
        {
            
        }
        else if sender.selectedSegmentIndex == 1
        {
            
        }
        else if sender.selectedSegmentIndex == 2
        {
            
        }
        else if sender.selectedSegmentIndex == 3
        {
            
        }
        else
        {
            
        }
        
    }
    
    // MARK: Steps_Check_List (TableView)
    
    
    
}
