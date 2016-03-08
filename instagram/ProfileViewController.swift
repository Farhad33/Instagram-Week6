//
//  ProfileViewController.swift
//  instagram
//
//  Created by Majid Rahimi on 3/7/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import Parse


class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (result) -> Void in
            self.performSegueWithIdentifier("logOutSegue", sender: nil)

        }
    }
    
    
  }
