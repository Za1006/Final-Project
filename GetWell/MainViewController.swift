//
//  MainViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

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
    var timer: NSTimer?
    var index0Count = 300
    var index1Count = 600
    var index2Count = 900
    var index3Count = 1200
    
    let avQueuePlayer = AVQueuePlayer()
    var songs = Array<Song>()
    var currentSong: Song?
    var nowPlaying: Bool = false
    
    
    @IBOutlet weak var nextMeditation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    
    var remainingCharacters = ["Obi-Wan Kenobi", "Leia Organa", "R2-D2", "Luke Skywalker", "Grand Moff Tarkin", "Darth Vader"]

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupAudioSession()
        configurePlaylist()
        loadCurrentSong()


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
    

    
    @IBAction func segmentedIndexTapped(sender: UISegmentedControl)
    {
        
//        timeSegmentedControl.addTarget(self, action: "action:", forControlEvents: .TouchUpInside)

        if sender.selectedSegmentIndex == 0
        {
            index0Count = 300
            startTimer()
            
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
    
    func setNotification()
    {
//        if originalCount == 0
//        {
//            // beep beep
//        }
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
////        originalCount = originalCount - 1
////        let newMinuteCount = originalCount/60
////        let newSecondCount = originalCount%60
//////        countLabel.text = String("\(newMinuteCount):\(newSecondCount)")
////        
//        if originalCount == 0
//        {
//            stopTimer()
//        }
//    }
    
    
//    Mark: Audio
    func setupAudioSession()
    {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted
            {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                } catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                } catch _ {
                }
            }
            else
            {
                print("Audio session could not be configured; user denied permission.")
            }
        })
    }
    
    
    func configurePlaylist()
    {
        let acoustic = Song(title: "Acoustic Breeze", artist: "Benjamin Tissot", filename: "acousticbreeze")
        songs.append(acoustic)
        currentSong = acoustic
        
        let betterdays = Song(title: "Better Days", artist: "Benjamin Tissot", filename: "betterdays")
        songs.append(betterdays)
        
        let deepblue = Song(title: "Deep Blue", artist: "Benjamin Tissot", filename: "deepblue")
        songs.append(deepblue)
        
        let enigmatic = Song(title: "Enigmatic", artist: "Benjamin Tissot", filename: "enigmatic")
        songs.append(enigmatic)
        
        let november = Song(title: "November", artist: "Benjamin Tissot", filename: "november")
        songs.append(november)
        
        
        let relaxing = Song(title: "Relaxing", artist: "Benjamin Tissot", filename: "relaxing")
        songs.append(relaxing)
        
        
        let sadday = Song(title: "Sadday", artist: "Benjamin Tissot", filename: "sadday")
        songs.append(sadday)
        
        
        let slowmotion = Song(title: "Slowmotion", artist: "Benjamin Tissot", filename: "slowmotion")
        songs.append(slowmotion)
        
        
        let tomorrow = Song(title: "Tomorrow", artist: "Benjamin Tissot", filename: "tomorrow")
        songs.append(tomorrow)
    }
    
    func loadCurrentSong()
    {
        avQueuePlayer.removeAllItems()
        if let song = currentSong
        {
            song.playerItem.seekToTime(CMTimeMakeWithSeconds(0.0, 1))
            avQueuePlayer.insertItem(song.playerItem, afterItem: nil)
          
        }
    }
    
    func togglePlayback(play: Bool)
    {
        nowPlaying = play
        if play
        {
            
            avQueuePlayer.play()
        }
        else
        {
            
            avQueuePlayer.pause()
        }
    }
    
    
    // MARK: Steps_Check_List (TableView)
    
    
    
}
