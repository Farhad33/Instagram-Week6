//
//  LoginViewController.swift
//  instagram
//
//  Created by Majid Rahimi on 3/5/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import Parse


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var errorMessage = "Please try again later"
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()



    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func displayError(title: String,_ message: String) {
        var alret = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alret.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alret, animated: true, completion: nil)
    }
    
    
    
    func waitingIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    
    @IBAction func onSignIn(sender: AnyObject) {
        
        if usernameField.text == "" || passwordField.text == "" {
            displayError("Error", "Please enter username and password")
            
        } else {
            waitingIndicator()
            
            PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in

                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if user != nil {
                    print("you're logged in!")
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                }else {
                    if let errorString = error!.userInfo["error"] as? String {
                        self.errorMessage = errorString
                    }
                    self.displayError("Failed SignIn", self.errorMessage)
                }
            }
        }
    }
    
    
    

    @IBAction func onSignUp(sender: AnyObject) {
        if usernameField.text == "" || passwordField.text == "" {
            displayError("Error", "Please enter username and password")
            
        } else {
            waitingIndicator()
            
            let newUser = PFUser()
            newUser.username = usernameField.text
            newUser.password = passwordField.text
            
            newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if success {
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    print("Yay, created a user!")
                    self.performSegueWithIdentifier("loginSegue", sender: nil)
                } else {
                    if let errorString = error!.userInfo["error"] as? String {
                        self.errorMessage = errorString
                    }
                    self.displayError("Failed SignUp", self.errorMessage)
                    
                }
            }
        }
    }
    


}
