//
//  ActionSettingViewController.swift
//  Penize
//
//  Created by Josef Antoni on 05.04.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import CoreData

class ActionSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myList : Array<AnyObject> = []

    @IBOutlet var tableView: UITableView!
    @IBOutlet var nameEnterTxtField: UITextField!
    @IBOutlet var checkMarkSave: UIImageView!
    @IBOutlet var labelText: UILabel!
    @IBOutlet var newActivityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        //self.labelText.alpha = 0
        self.labelText.font = UIFont(name: "Zapfino", size: 16)
        self.labelText.text = "Activity spending List"
        self.newActivityLabel.font = UIFont(name: "Zapfino", size: 14)
        self.newActivityLabel.text = "New Activity:"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Move 1 VC back
    */
    @IBAction func backBtn(sender: AnyObject) {
        
        let addMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("AddPrefVC") as! PreferencesViewController
        self.navigationController?.pushViewController(addMainVC, animated: true)
        
    }

    @IBAction func Save(sender: UIButton) {
        var appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        //solve empty table rows when added empty string
        if(nameEnterTxtField.text.isEmpty == false){
            var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Activity", inManagedObjectContext: context)
            newUser.setValue(nameEnterTxtField.text, forKey: "name")
            context.save(nil)
            //reload view
            let reloadTable = self.storyboard?.instantiateViewControllerWithIdentifier("ActionConfigVC") as! ActionSettingViewController
            self.navigationController?.pushViewController(reloadTable, animated: true)
        }
        
        
    }
    
    override func viewDidAppear(animated: Bool){
        var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        var request = NSFetchRequest(entityName: "Activity")
        
        myList = context.executeFetchRequest(request, error: nil)!
        
        tableView.reloadData()
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID: NSString = "Cell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID as String) as! UITableViewCell
        
        if let ip = indexPath as NSIndexPath? {
            
            var data: NSManagedObject = myList[ip.row] as! NSManagedObject
            cell.textLabel?.text = data.valueForKeyPath("name") as? String
            
            //cell.detailTextLabel?.text = "\(name)"
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        //println(swiftBlogs[row])*/
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        if editingStyle == UITableViewCellEditingStyle.Delete{
            if let tv = tableView as UITableView? {
                
                context.deleteObject(myList[indexPath.row] as! NSManagedObject)
                myList.removeAtIndex(indexPath.row)
                tv.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
            
            var error: NSError? = nil
            if !context.save(&error){
                abort()
            }
        }
    }


}
