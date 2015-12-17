//
//  ViewController.swift
//  Testing Segmented Control
//
//  Created by Michael Reynolds on 12/15/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class MainController: UIViewController
{
    
    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    var timer: NSTimer?
    var paused = true
    var originalCount = 600
    
    let avQueuePlayer = AVQueuePlayer()
    var songs = Array<Song>()
    var currentSong: Song?
    var nowPlaying: Bool = false

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
    }
    
    @IBAction func changedSortedCriteria(sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            stopTimer()
            originalCount = 300
            countLabel.text = "5:00"
            startTimer()
            loadCurrentSong()
            togglePlayback(true)
        }
        else if sender.selectedSegmentIndex == 1
        {
            stopTimer()
            originalCount = 600
            countLabel.text = "10:00"
            startTimer()
            loadCurrentSong()
            togglePlayback(true)
        }
        else if sender.selectedSegmentIndex == 2
        {
            stopTimer()
            originalCount = 900
            countLabel.text = "15:00"
            startTimer()
            loadCurrentSong()
            togglePlayback(true)
        }
    }
    
    @IBAction func buttonTapped(sender: UIButton!)
    {
        playNotification()
    }
    
    func playNotification()
    {
        let soundURL = NSBundle.mainBundle().URLForResource("sessionOver", withExtension: "m4a")!
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
    func startTimer()
    {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateUI", userInfo: nil, repeats: true)
        updateUI()
    }
    
    func stopTimer()
    {
        timer?.invalidate()
        timer = nil
    }
    
    func updateUI()
    {
        originalCount = originalCount - 1
        let newMinuteCount = originalCount/60
        let newSecondCount = originalCount%60
        countLabel.text = String("\(newMinuteCount):\(newSecondCount)")
        
        if originalCount == 0
        {
            stopTimer()
            playNotification()
        }
    }
    
    // MARK: - Audio
    
    func setupAudioSession()
    {
        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
            if granted
            {
                do {
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
//                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, withOptions: .DuckOthers)
                }
                catch _ {
                }
                do {
                    try AVAudioSession.sharedInstance().setActive(true)
                }
                catch _ {
                    
                }
            }
            else
            {
                print("Audio session could not be configured: user denied permission")
            }
        })
        
    }
    
    func configurePlaylist()
    {
        let acoustic = Song(title: "Happiness", artist: "Benjamin Tissot", filename: "happiness", albumArtwork: "Acoustic")
        songs.append(acoustic)
        
        let betterdays = Song(title: "BetterDays", artist: "Ben", filename: "bensound-betterdays", albumArtwork: "Ben")
        songs.append(betterdays)
        currentSong = betterdays
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
    
    @IBAction func skipForwardTapped(sender: UIButton)
    {
        let currentSongIndex = (songs as NSArray).indexOfObject(currentSong!)
        let nextSong: Int
        
        if currentSongIndex + 1 >= songs.count
        {
            nextSong = 0
        }
        else
        {
            nextSong = currentSongIndex + 1
        }
        currentSong = songs[nextSong]
        loadCurrentSong()
        togglePlayback(true)
    }
    
    @IBAction func playPauseTapped(sender: UIButton)
    {
        togglePlayback(!nowPlaying)
    }
    
    
}

