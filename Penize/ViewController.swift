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
    
    var myFirstLabel: UILabel!
    var mySecondLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 117/255, green: 209/255, blue: 255/255, alpha: 1.0)
        self.navigationController?.navigationBarHidden = true
        
        myFirstLabel = UILabel()
        myFirstLabel.text = "My first"
        myFirstLabel.font = UIFont(name: "Zapfino", size: 48)
        myFirstLabel.font = UIFont.systemFontOfSize(36)
        myFirstLabel.sizeToFit()
        myFirstLabel.center = CGPoint(x: 100, y: 40)
        view.addSubview(myFirstLabel)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.0, options: nil, animations: {
            self.myFirstLabel.center = CGPoint(x: 100, y: 40 + 200)
            
            }, completion: nil)
        
        
        mySecondLabel = UILabel()
        mySecondLabel.text = "iPhone"
        mySecondLabel.font = UIFont(name: "Zapfino", size: 48)
        mySecondLabel.font = UIFont.systemFontOfSize(48)
        mySecondLabel.sizeToFit()
        mySecondLabel.center = CGPoint(x: 200, y: 90)
        view.addSubview(mySecondLabel)
        
        UIView.animateWithDuration(2.0, delay: 0.5, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: nil, animations: {
            self.mySecondLabel.center = CGPoint(x: 200, y: 90 + 200)
            
            }, completion: nil)
        
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: "timeToMoveOn", userInfo: nil, repeats: false)
    }
    
    func timeToMoveOn() {
        self.performSegueWithIdentifier("goToMainUI", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

