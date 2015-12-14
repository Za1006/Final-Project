//
//  SetReminderPopOverViewController.swift
//  GetWell
//
//  Created by Michael Reynolds on 12/10/15.
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

}