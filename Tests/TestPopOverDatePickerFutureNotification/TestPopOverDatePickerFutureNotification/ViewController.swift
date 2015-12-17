//
//  ViewController.swift
//  TestPopOverDatePickerFutureNotification
//
//  Created by Michael Reynolds on 12/16/15.
//  Copyright © 2015 Michael Reynolds. All rights reserved.
//

import UIKit

@objc protocol DatePickerDelegate
{
    func dateWasChosen(date: NSDate)
}

class ViewController: UIViewController, DatePickerDelegate, UIPopoverPresentationControllerDelegate
{
    
    @IBOutlet weak var nextMeditation: UILabel!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "SetReminderSegue"
        {
            let destVC = segue.destinationViewController as! PopOverVC
            destVC.popoverPresentationController?.delegate = self
            destVC.preferredContentSize = CGSizeMake(400.0, 600)
        }
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
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd yyyy MM:hh", options: 0, locale: NSLocale.currentLocale())
        let formattedTime = formatter.stringFromDate(x).uppercaseString
        
        return String(formattedTime)
    
    }
    
    // MARK: - UIPopoverPresentationController Delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
        //can also just type return .None
    }

}

class PopOverVC: UIViewController
{
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    
    var delegate: DatePickerDelegate?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        delegate?.dateWasChosen(datePicker.date)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

