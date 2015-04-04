//
//  QuestionsViewController.swift
//  Penize
//
//  Created by Josef Antoni on 04.04.15.
//  Copyright (c) 2015 Josef Antoni. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtn(sender: AnyObject) {
        
        let addMainVC = self.storyboard?.instantiateViewControllerWithIdentifier("mainVC") as WelcomeViewController
        self.navigationController?.pushViewController(addMainVC, animated: true)
        
    }
}
