//
//  ViewController.swift
//  Penize
//
//  Created by Josef Antoni on 21.03.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var userTxtField: UITextField!
    
    @IBOutlet weak var passTxtField: UITextField!

    @IBOutlet weak var tableRows: UITableView!

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func Save(sender: UIButton) {
        statusLabel.text = "Saved"
        var appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Acc", inManagedObjectContext: context)
        newUser.setValue(userTxtField.text, forKey: "user")
        newUser.setValue(passTxtField.text, forKey: "pass")
        
        context.save(nil)
        println("Saved")
        
    }
    
    /**
    *   Present of all rows from db
    */
    @IBAction func loadBtn(sender: UIButton) {
        var appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var request = NSFetchRequest(entityName: "Acc")
        request.returnsObjectsAsFaults = false
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)!
      
        if (results.count > 0){
        
            for res in results{
                println(res)
            }
            
        }else{
        println("Nic tu není.")
        }
    
        statusLabel.text = "Loaded"
    }
    
    /**
    *   Delete of all rows
    */
    @IBAction func purge(sender: UIButton) {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "Acc")
        
        var myList = context.executeFetchRequest(request, error: nil)!
        
            var bas: NSManagedObject!
            
            
            for bas: AnyObject in myList
            {
                context.deleteObject(bas as NSManagedObject)
            }
            
            myList.removeAll(keepCapacity: false)
            
            context.save(nil)
        
            statusLabel.text = "Deleted"

    }
    
    
}

