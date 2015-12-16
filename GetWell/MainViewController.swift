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
@objc protocol MediaPlayerViewDelegate
{
    func timerWasChosen(timerCount: Int)
    
}
class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate, DatePickerDelegate, MediaPlayerViewDelegate
{
    
    var delegate: MediaPlayerViewController?

    var index0Count = 300
    var index1Count = 600
    var index2Count = 900
    var index3Count = 1200
    var timer: NSTimer?
    var timers = Array<Timer>()
//    var currentTimerSet: Timer?
    
    

    @IBOutlet weak var nextMeditation: UILabel!
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
//        delegate?.timerWasChosen(String-timeSegmentedControl.selectedSegmentIndex(0))
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
                destVC.delegate = self
                destVC.preferredContentSize = CGSizeMake(400.0, 216.0)
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
//        originalCount = timerCount
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
        formatter.dateFormat = NSDateFormatter.dateFormatFromTemplate("MMM dd yyyy HH:mm", options: 0, locale: NSLocale.currentLocale())
        let formattedTime = formatter.stringFromDate(x).uppercaseString
        
        return String(formattedTime)
    }

    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        
        if sender.selectedSegmentIndex == 0
        {
            index0Count = 300
            startTimer()
        }
        else if sender.selectedSegmentIndex == 1
        {
            index1Count = 600
            startTimer()
        }
        else if sender.selectedSegmentIndex == 2
        {
            index2Count = 900
            startTimer()
        }
        else
        {
           if sender.selectedSegmentIndex == 3
           {
            index3Count = 1200
            startTimer()
            }
        }
       self.reloadInputViews()
    }
    
        func startTimer()
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateUI", userInfo: nil, repeats: true)
        }

            func stopTimer()
            {
                timer?.invalidate()
                timer = nil
            }
//    func updateUI()
//    {
//        index0Count = index0Count - 1
//        let fiveMinuteCount = index0Count/60
//        let fiveSecondCount = index0Count%60
//        index1Count = index1Count - 1
//        let tenMinuteCount = index1Count/60
//        let tenSecondCount = index1Count%60
//        index2Count = index2Count - 1
//        let fifteenMinuteCount = index2Count/60
//        let fifteenSecondCount = index2Count%60
//        index3Count = index3Count - 1
//        let twentyMinuteCount = index3Count/60
//        let twentySecondCount = index3Count%60
//        
//        countLabel.text = String("\(newMinuteCount):\(newSecondCount)")
//        
//        if originalCount == 0
//        {
//            stopTimer()
//        }
//    }
//    

}

    


