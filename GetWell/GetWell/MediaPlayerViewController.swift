//
//  MediaPlayerViewController.swift
//  GetWell
//  Music: http://www.bensound.com/royalty-free-music
//  Created by Elizabeth Yeh on 12/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation



class MediaPlayerViewController: UIViewController
{
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var countDownView: UIPickerView!
    
    @IBOutlet var playPauseButton: UIButton!
    
    let avQueuePlayer = AVQueuePlayer()
    var songs = Array<Song>()
    var currentSong: Song?
    var nowPlaying: Bool = false
    
    var timer: NSTimer
    var fiveMinutesCount = 5
    var tenMinutesCount = 10
    var fifteenMinutesCount = 15
    var twentyMinutesCount = 20
    
    var delegate: MediaPlayerViewController?

    
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
    
    


// MARK: - Navigation

//   Don't need the segue just need the function
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//       if segue.identifier == "ShowTimerCountdownSegue"
//       {
//        let countdownPickerVC = segue.destinationViewController as!CountdownPickerViewController
//        countdownPickerVC.delegate = self
//        }
//    }

    
//    MARK: - Action Handlers
    
    
    @IBAction func playPauseTapped(sender: UIButton)
    {
        togglePlayback(!nowPlaying)
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
    
    @IBAction func skipBackTapped(sender: UIButton)
    {
        avQueuePlayer.seekToTime(CMTimeMakeWithSeconds(0.0, 1))
        if !nowPlaying
        {
            togglePlayback(true)
        }
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
            songTitleLabel.text = song.title
            artistLabel.text = song.artist
//          countDownView.image = UIPickerView(time: song.countDownView)
        }
    }
    
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

    func togglePlayback(play: Bool)
    {
        nowPlaying = play
        if play
        {
            playPauseButton.setImage(UIImage(named: "Pause"), forState: UIControlState.Normal)
            avQueuePlayer.play()
        }
        else
        {
            playPauseButton.setImage(UIImage(named: "Play"), forState: UIControlState.Normal)
            avQueuePlayer.pause()
        }
    }
}
