//
//  MainViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
    
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var textView: UITextView!
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "SetReminderSegue"
        {
            let destVC = segue.destinationViewController as! SetReminderPopOverViewController
                destVC.characters = remainingCharacters
                destVC.popoverPresentationController?.delegate = self
                destVC.delegate = self //connects
            let contentHeight = 44.0 * CGFloat(remainingCharacters.count)
                destVC.preferredContentSize = CGSizeMake(200.0, contentHeight)
        }
    }
    
    // MARK: - UIPopoverPresentationController Delegate
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.None
        //can also just type return .None
    }

    
    func setNotificationTapped()
    {
        
    }
    @IBAction func changeSortCriteria(sender: UISegmentedControl)
    {
        
    }
    
    @IBAction func setNotificationTapped(sender: UIBarButtonItem)
    {
        
    }
// popover view to time picker
    
}
