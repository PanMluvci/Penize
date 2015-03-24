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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var userTxtField: UITextField!
    
    @IBOutlet weak var passTxtField: UITextField!

    @IBAction func Save(sender: UIButton) {
        var appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Acc", inManagedObjectContext: context)
        newUser.setValue(userTxtField.text, forKey: "user")
        newUser.setValue(passTxtField.text, forKey: "pass")
        
        context.save(nil)
        println(newUser)
        println("Saved")
    }
    
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
        println("Stala se asi chyba, nebo je to 0")
        }
        
    }
}

