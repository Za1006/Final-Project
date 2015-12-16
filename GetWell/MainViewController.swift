//
//  MainViewController.swift
//  GetWell
//
//  Created by Elizabeth Yeh on 12/10/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import CoreData

@objc protocol DatePickerDelegate
{
    func dateWasChosen(date: NSDate)
}



class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITableViewDataSource, UITableViewDelegate, DatePickerDelegate
{
    
    
    
    
    @IBOutlet weak var nextMeditation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImage!
    
    var remainingCharacters = []
    
    var stepsArray = Array<Steps>()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let checkImg = UIImage(named: "checked.png")
    let uncheckImg = UIImage(named: "unchecked.png")
    var buttonIndex: NSIndexPath!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "Steps")
        do
        {
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Steps]
            stepsArray = fetchResults!
        }
        catch
        {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }

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
    
    // MARK: Steps_Check_List (TableView)
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int
        {
            return 1
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return stepsArray.count
        }
        
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("StepsListCell", forIndexPath: indexPath) as! StepListCell
            
            let todoItem = stepsArray[indexPath.row]
            
            if todoItem.title == nil
            {
                cell.checkBox.setImage(uncheckImg, forState: UIControlState.Normal)
                cell.stepsLabel.text = "Breath"
            }
            else
            {
                cell.stepsLabel.text = todoItem.title
            }
            
            if todoItem.isDone
            {
                cell.checkBox.setImage(checkImg, forState: UIControlState.Normal)
                cell.backgroundColor = UIColor(red: 0.28, green: 0.20, blue: 0.52, alpha: 1)
                cell.stepsLabel.textColor = UIColor.whiteColor()
            }
            else
            {
                cell.checkBox.setImage(uncheckImg, forState: UIControlState.Normal)
                cell.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
                cell.stepsLabel.textColor = UIColor.greenColor()
            }
            
            return cell
    }

    
         //Override to support conditional editing of the table view.
        func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
        {
            // Return false if you do not want the specified item to be editable.
            return false
        }

        // Override to support editing the table view.
        func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
        {
            let todoItem = stepsArray[indexPath.row]
            
            if todoItem.isDone
            {
                let todoItem = stepsArray[indexPath.row]
                
                if editingStyle == .Delete
                {
                    stepsArray.removeAtIndex(indexPath.row)
                    managedObjectContext.deleteObject(todoItem)
                }
                
                saveSlot1()
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
//            else
//            {
//                errorLabel.text = "Check tasks before you delete them!"
//            }
        }


    
    // MARK: Steps_Check_List (TableView)
    

        //MARK: - ACTION HANDLERS 3: REVENGE OF THE HANDLERS
        @IBAction func addTodo(sender: UIButton)
        {
            let todoItem = NSEntityDescription.insertNewObjectForEntityForName("Steps", inManagedObjectContext: managedObjectContext) as! Steps
            stepsArray.append(todoItem)
            tableView.reloadData()
        }
        
        @IBAction func checkboxPressed(sender: UIButton)
        {
            let contentView = sender.superview
            let cell = contentView?.superview as! StepListCell
            let indexPath = tableView.indexPathForCell(cell)
            let todoItem = stepsArray[indexPath!.row]
            
            todoItem.title = cell.stepsLabel.text //just in case they don't press enter when they're typing in their todo and just immediately check it off
            
            if sender.currentImage == uncheckImg
            {
                cell.checkBox.setImage(checkImg, forState: UIControlState.Normal)
                todoItem.isDone = true
                //            cell.backgroundColor = UIColor.lightTextColor()
                cell.backgroundColor = UIColor(red:0.38, green:0.00, blue:0.02, alpha:1.0)
                cell.stepsLabel.textColor = UIColor.whiteColor()
            }
            else
            {
                cell.checkBox.setImage(uncheckImg, forState: UIControlState.Normal)
                todoItem.isDone = false
                cell.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
                cell.stepsLabel.textColor = UIColor.greenColor()
            }
            
            tableView.reloadData()
            
            saveSlot1()
        }
        
        func saveSlot1()
        {
            do
            {
                try managedObjectContext.save()
                //save all managed objects
            }
            catch
            {
                let nserror = error as NSError
                NSLog(" SOMETHING WENT WRONG \(nserror), \(nserror.userInfo)")
                abort() //<<<<<
            }
        }
    }




