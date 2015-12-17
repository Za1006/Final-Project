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

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate, DatePickerDelegate, UITableViewDataSource, UITableViewDelegate
{
    
   // var todoList = ["Find a secluded area", "Begin Breathing exercize", "Focus with Purpose"]
    
    //@IBOutlet weak var image: UIImage!
    
    var todoArray = Array<Todo>()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextMeditation: UILabel!
    
    let checkImg = UIImage(named: "checked.png")
    let uncheckImg = UIImage(named: "unchecked.png")
    var buttonIndex: NSIndexPath!
    var remainingCharacters = []
   

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        let fetchRequest = NSFetchRequest(entityName: "Todo")
        do {
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Todo]
            todoArray = fetchResults!
            }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
            }

    }
        
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
        
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodoCell", forIndexPath: indexPath) as! TodoCell
        
        let todoItem = todoArray[indexPath.row]
        
        if todoItem.title == nil
        {
            cell.checkbox.setImage(uncheckImg, forState: UIControlState.Normal)
            cell.todoLabel.text = ""
        }
        else
        {
            cell.todoLabel.text = todoItem.title
        }
        
        if todoItem.isDone
        {
            cell.checkbox.setImage(checkImg, forState: UIControlState.Normal)
            cell.backgroundColor = UIColor(red: 0.28, green: 0.20, blue: 0.52, alpha: 1)
            cell.todoLabel.textColor = UIColor.whiteColor()
        }
        else
        {
            cell.checkbox.setImage(uncheckImg, forState: UIControlState.Normal)
            cell.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
            cell.todoLabel.textColor = UIColor.blackColor()
        }
        
        return cell
    }

    // Override to support conditional editing of the table view.
     func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        let todoItem = todoArray[indexPath.row]
        
        if todoItem.isDone
        {
            _ = todoArray[indexPath.row]
            
            if editingStyle == .Delete
            {
                todoArray.removeAtIndex(indexPath.row)
                //managedObjectContext.deleteObject(todoItem)
            }
            
            saveSlot1()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    //MARK: - Action Handlers
    
    
    @IBAction func addTodo(sender: UIButton)
    {
        let todoItem = NSEntityDescription.insertNewObjectForEntityForName("todoList", inManagedObjectContext: managedObjectContext) as! Todo
        todoArray.append(todoItem)
        tableView.reloadData()
    }
    
        @IBAction func checkboxPressed(sender: UIButton)
    {
        let contentView = sender.superview
        let cell = contentView?.superview as! TodoCell
        let indexPath = tableView.indexPathForCell(cell)
        let todoItem = todoArray[indexPath!.row]
        
        todoItem.title = cell.todoLabel.text //just in case they don't press enter when they're typing in their todo and just immediately check it off
        
        if sender.currentImage == uncheckImg
        {
            cell.checkbox.setImage(checkImg, forState: UIControlState.Normal)
            todoItem.isDone = true
            //            cell.backgroundColor = UIColor.lightTextColor()
            cell.backgroundColor = UIColor(red:0.38, green:0.00, blue:0.02, alpha:1.0)
            cell.todoLabel.textColor = UIColor.whiteColor()
        }
        else
        {
            cell.checkbox.setImage(uncheckImg, forState: UIControlState.Normal)
            todoItem.isDone = false
            cell.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
            cell.todoLabel.textColor = UIColor.blackColor()
        }
        
        tableView.reloadData()
        saveSlot1()
    }
    

    // MARK: - Navigation
    
// MARK: -    Media Player
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "ShowMediaSegue"
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
            NSLog("SOMETHING WENT WRONG \(nserror), \(nserror.userInfo)")
            abort() //<<<<<
        }
    }

}
