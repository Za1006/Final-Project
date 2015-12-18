//
//  ViewController.swift
//  ChecklistTest
//
//  Created by Michael Reynolds on 12/16/15.
//  Copyright © 2015 Michael Reynolds. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var itemDescription = Array<Entity>()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newTask: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fetchRequest = NSFetchRequest(entityName: "Entity")
        do
        {
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Entity]
            itemDescription = fetchResults!
        }
        catch
        {
            let nserror = error as NSError
            NSLog("Unresoved error \(nserror), \(nserror.userInfo)")
            abort()
        }

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemDescription.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("aCell", forIndexPath: indexPath) as! TableViewCell
        
        let aTask = itemDescription[indexPath.row]
        if aTask.item == nil
        {
//            cell.toDoText.becomeFirstResponder()
        }
        else
        {
            cell.toDoText.text = aTask.something
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            let aTask = itemDescription[indexPath.row]
            itemDescription.removeAtIndex(indexPath.row)
            managedObjectContext.deleteObject(aTask)
            
//            (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
            saveContext()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    //     MARK: TextField Delegate
    
    func textFieldShouldReturn(toDoText: UITextField) -> Bool
    {
        var rc = false
        
        if toDoText.text != ""
        {
            rc = true
            let contentView = toDoText.superview
            let cell = contentView?.superview as! TableViewCell
            let indexPath = tableView.indexPathForCell(cell)

            let aTask = itemDescription[indexPath!.row]
            aTask.something = toDoText.text
            toDoText.resignFirstResponder()
            
//            (UIApplication.sharedApplication().delegate as! AppDelegate).saveContext()
            saveContext()
        }
        
        return rc
    }
    
    // MARK: Action Handlers
    
    @IBAction func newTask(sender: UIBarButtonItem)
    {
        let aTask = NSEntityDescription.insertNewObjectForEntityForName("Entity", inManagedObjectContext: managedObjectContext) as! Entity
        itemDescription.append(aTask)
        tableView.reloadData()
    }
    
    @IBAction func doneButton(sender: UIButton)
    {
        let contentView = sender.superview
        let cell = contentView?.superview as! TableViewCell
        let indexPath = tableView.indexPathForCell(cell)

        let aTask = itemDescription[indexPath!.row]
        
        if sender.currentTitle == "☑"
        {
            cell.backgroundColor = UIColor.whiteColor()
            sender.setTitle("☐", forState: UIControlState.Normal)
            aTask.item = false
        }
        else
        {
            cell.backgroundColor = UIColor.greenColor()
            sender.setTitle("☑", forState: UIControlState.Normal)
            aTask.item = true
        }
    }
    
    //MARK: - Private
    
    func saveContext()
    {
        do
        {
            try managedObjectContext.save()
        }
        catch
        {
            let nserror = error as NSError
            NSLog("Unresoved error \(nserror), \(nserror.userInfo)")
            abort()
        }
    }
}

// button.hidden = true
// button.enabled = false in rows in section if rows == 3
// index 0 of array

