//
//  StepsListViewController.swift
//  GetWell
//
//  Created by Keron Williams on 12/15/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import UIKit
import CoreData

class StepsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    
    var stepsArray = Array<Steps>()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    let checkImg = UIImage(named: "checked.png")
    let uncheckImg = UIImage(named: "unchecked.png")
    var stepsLabel: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        title = "Steps List"
        
        let fetchRequest = NSFetchRequest(entityName: "Steps")
        do {
            let fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Steps]
            stepsArray = fetchResults!
        }
        catch {
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        // MARK: - Table view data source
        
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
            
        let cell =
            tableView.dequeueReusableCellWithIdentifier("TodoCell",
            forIndexPath: indexPath) as! TodoCell
            
        }
            


}








