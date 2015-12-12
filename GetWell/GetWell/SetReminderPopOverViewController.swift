//
//  SetReminderPopOverViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/12/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit

class SetReminderPopOverViewController: UIViewController
{

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIButton!
    
    var delegate: DatePickerDelegate?
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
