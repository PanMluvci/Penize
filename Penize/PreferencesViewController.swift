//
//  PreferencesViewController.swift
//  Penize
//
//  Created by Josef Antoni on 26.03.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit
import CoreData

class PreferencesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func moveToActionVC(sender: AnyObject) {
        let addPrefVC = self.storyboard?.instantiateViewControllerWithIdentifier("ActionConfigVC") as! ActionSettingViewController
        self.navigationController?.pushViewController(addPrefVC, animated: true)
    }
    
    
    /*
    *   Navigation back to WelcomeViewController
    */
    @IBAction func backBtn(sender: AnyObject) {
        
        let addMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as! WelcomeViewController
        self.navigationController?.pushViewController(addMainVC, animated: true)
        
    }
    
    
    
}
