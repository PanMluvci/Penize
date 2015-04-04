    //
    //  WelcomeViewController.swift
    //  Penize
    //
    //  Created by Josef Antoni on 27.03.15.
    //  Copyright (c) 2015 Josef Antoni. All rights reserved.
    //
    
    import UIKit
    import CoreData
    
    class WelcomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
        @IBOutlet var tableView: UITableView!
       // let textCellIdentifier = "TextCell"
        let swiftBlogs = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
         @IBOutlet weak var table: UITableView!
        
        var myList : Array<AnyObject> = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationController?.navigationBarHidden = true
            // Do any additional setup after loading the view, typically from a nib.
            self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
            tableView.delegate = self
            tableView.dataSource = self
            
            
        }
        
        override func viewDidAppear(animated: Bool){
            var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            var context: NSManagedObjectContext = appDelegate.managedObjectContext!
            var request = NSFetchRequest(entityName: "Wallet")
            
            myList = context.executeFetchRequest(request, error: nil)!

            tableView.reloadData()
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        /**
        *   Showing message. If YES then Delete all rows
        */
        @IBAction func purge(sender: UIButton) {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let context: NSManagedObjectContext = appDelegate.managedObjectContext!
            let request = NSFetchRequest(entityName: "Wallet")
            myList = context.executeFetchRequest(request, error: nil)!
            
            var alert = UIAlertController(title: "Do you really want to purge all your spending?", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            alert.addAction(UIAlertAction(title: "Yes", style: .Destructive, handler: { action in
                switch action.style{
                case .Default:
                    break
                    
                case .Cancel:
                    break
                    
                case .Destructive:
                    
                    var bas: NSManagedObject!
                    
                    for bas: AnyObject in self.myList
                    {
                        context.deleteObject(bas as NSManagedObject)
                    }
                    
                    self.myList.removeAll(keepCapacity: false)
                    
                    context.save(nil)
                    
                }
            }))
            self.tableView.reloadData()

            
        }
        
        /**
        *   Navigation to AddEntryViewController
        */
        @IBAction func addNewEntryBtn(sender: AnyObject) {
            let addEntryVC = self.storyboard?.instantiateViewControllerWithIdentifier("AddEntryVC") as AddEntryViewController
            self.navigationController?.pushViewController(addEntryVC, animated: true)
        }
        
        /**
        *   Navigation to PreferencesViewController
        */
        @IBAction func prefbtn(sender: AnyObject) {
            let addPrefVC = self.storyboard?.instantiateViewControllerWithIdentifier("AddPrefVC") as PreferencesViewController
            self.navigationController?.pushViewController(addPrefVC, animated: true)
        }
        
        /**
        *   Navigation to PreferencesViewController
        */
        @IBAction func questionBtn(sender: AnyObject) {
            let questionVC = self.storyboard?.instantiateViewControllerWithIdentifier("QuestionVC") as QuestionsViewController
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return myList.count
        }
        /*
            loading stuff from DB to table
        */
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let CellID: NSString = "Cell"
            var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell
            
            if let ip = indexPath as NSIndexPath? {
              
                var data: NSManagedObject = myList[ip.row] as NSManagedObject
                cell.textLabel?.text = data.valueForKeyPath("price") as? String
                
                var price = data.valueForKeyPath("activity") as String
                var note = data.valueForKeyPath("note") as String

                cell.detailTextLabel?.text = "\(price) - \(note)"
            }
            
            return cell
        }
        
        // metoda po stisku začne něco dělat
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            /*tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
            let row = indexPath.row
            //println(swiftBlogs[row])*/
        }
        func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
        }
        
        /*
        *   Deleting selected rows with swipe. + error handle
        */
        func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            let context: NSManagedObjectContext = appDelegate.managedObjectContext!
            
            if editingStyle == UITableViewCellEditingStyle.Delete{
                if let tv = tableView as UITableView? {
                    
                context.deleteObject(myList[indexPath.row] as NSManagedObject)
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
