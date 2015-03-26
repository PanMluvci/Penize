//
//  AddEntryViewController.swift
//  Penize
//
//  Created by Josef Antoni on 26.03.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import CoreData

class AddEntryViewController: UIViewController {
    
    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var passTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Save(sender: UIButton) {
        //statusLabel.text = "Saved"
        var appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Acc", inManagedObjectContext: context)
        newUser.setValue(userTxtField.text, forKey: "user")
        newUser.setValue(passTxtField.text, forKey: "pass")
        
        context.save(nil)
        println("Saved")
        
    }
    
    @IBAction func addNewEntryBtn(sender: AnyObject) {
     
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
}
