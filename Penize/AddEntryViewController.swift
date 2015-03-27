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
    
    @IBOutlet weak var costTxtField: UITextField!
    @IBOutlet weak var noteTxtField: UITextField!
    @IBOutlet weak var infoField: UILabel!
    @IBOutlet weak var checkmarkSave: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
        //infoField.hidden = true
        self.infoField.alpha = 0
        self.infoField.font = UIFont(name: "Zapfino", size: 20)
        self.infoField.text = "Activity Saved"
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
        newUser.setValue(costTxtField.text, forKey: "user")
        newUser.setValue(noteTxtField.text, forKey: "pass")
        animateCountdownLabel()
        context.save(nil)
        println("Saved")
        
       // infoPanelPrompt()
        
    }
   
    
    func animateCountdownLabel()
    {
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            self.checkmarkSave.hidden = true
            self.infoField.alpha = 1.0
            
            }) { (Bool) -> Void in
                UIView.animateWithDuration(1.5, animations: { () -> Void in
                    
                    self.infoField.alpha = 0.0
                    
                    }, completion: { (Bool) -> Void in
                      self.checkmarkSave.hidden = false
                })
        }
    }
    
    @IBAction func backHome(sender: AnyObject) {

        let addMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as WelcomeViewController
        self.navigationController?.pushViewController(addMainVC, animated: true)
        
    }
    
    var colors = ["Red","Yellow","Green","Blue"]
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return colors[row]
    }
    
}
