//
//  MainViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController
{
    
    @IBOutlet weak var image: UIImage!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var TimeSegmentedControl: UISegmentedControl!
    

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    popover with pickerView format
    func setReminderTapped()
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
