//
//  Post.swift
//  instagram
//
//  Created by Majid Rahimi on 3/8/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//
import UIKit
import Parse

class Post: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        let mediaPost = PFObject(className: "Post")
        
        mediaPost["media"] = getPFFileFromImage(image)
        mediaPost["author"] = PFUser.currentUser()
        mediaPost["caption"] = caption
        mediaPost["likesCount"] = 0
        mediaPost["commentsCount"] = 0
        
        mediaPost.saveInBackgroundWithBlock(completion)
        
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        
        return nil
    }
    
    class func resizeImage(image: UIImage?, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
