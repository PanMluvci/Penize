//
//  AddEntryViewController.swift
//  Penize
//
//  Created by Josef Antoni on 26.03.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import CoreData

class AddEntryViewController: UIViewController, UIPickerViewDelegate {
    
    var itemActivityValue:String = ""
    
    @IBOutlet weak var costTxtField: UITextField!
    @IBOutlet weak var noteTxtField: UITextField!
    @IBOutlet weak var infoField: UILabel!
    @IBOutlet weak var checkmarkSave: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
        self.infoField.alpha = 0
        self.infoField.font = UIFont(name: "Zapfino", size: 20)
        self.infoField.text = "Activity Saved"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
    *   Save spending activity with 3 parameters to the penize.xcdatamodel database.
    *   "context.save(nil)" is very important for saving operation!
    */
    @IBAction func Save(sender: UIButton) {
        var appDelegate: AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        var newUser: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("Wallet", inManagedObjectContext: context)
        newUser.setValue(costTxtField.text, forKey: "price")
        //solving activity emptyness if you will not move with pickerview
            if(itemActivityValue.isEmpty){
                itemActivityValue = activityValues[0]
            }
        newUser.setValue(itemActivityValue, forKey: "activity")
        newUser.setValue(noteTxtField.text, forKey: "note")

        animateCountdownLabel()
        context.save(nil)
        
    }
   
    /**
    *   Animation of save button when is touched. FadeOut and FadeIn, about 4 sec to take.
    *
    */
    func animateCountdownLabel()
    {
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.checkmarkSave.hidden = true
            self.infoField.alpha = 1.0
            
            }) { (Bool) -> Void in
                UIView.animateWithDuration(2.0, animations: { () -> Void in
                    
                    self.infoField.alpha = 0.0
                    
                    }, completion: { (Bool) -> Void in
                      self.checkmarkSave.hidden = false
                })
        }
    }
    
    /**
    *   Navigate back to the WelcomeViewController after done with activity insert.
    *
    */
    @IBAction func backHome(sender: AnyObject) {

        let addMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as WelcomeViewController
        self.navigationController?.pushViewController(addMainVC, animated: true)
        
    }
    
    var activityValues = ["0","1","2","3","4","5","6","7"]
    
    /**
    *   Number of selected components in Pickerview
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activityValues.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return activityValues[row]
    }
    
    /**
    *   Important method for store selected row to Variable for later use in INSERT to Database.
    */
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        itemActivityValue = activityValues[row]
    }

    
}
