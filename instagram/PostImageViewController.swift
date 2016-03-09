//
//  PostImageViewController.swift
//  instagram
//
//  Created by Majid Rahimi on 3/7/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.


import UIKit
import Parse

class PostImageViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var message: UITextField!
    
    var newImage = UIImage()
    
    var activityIndicator = UIActivityIndicatorView()

    @IBAction func chooseImage(sender: AnyObject) {
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageToPost.image = image
        
    }
    
    @IBAction func submit(sender: AnyObject) {
        
        waitingIndicator()
        
        newImage = Post.resizeImage(imageToPost.image!, newSize: CGSize(width: 300, height: 500))
    
        Post.postUserImage(newImage, withCaption: message.text) { (success: Bool, error: NSError?) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if error == nil {
                
                self.displayError("Image Posted!", "Your image has been posted successfully")
                
                self.imageToPost.image = UIImage(named: "Blank_woman.png")
                self.message.text = ""
            }else {
                self.displayError("Could not post image", "Please try again later")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        message.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func waitingIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    
    func displayError(title: String,_ message: String) {
        var alret = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alret.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alret, animated: true, completion: nil)
    }
    
  
    
}
