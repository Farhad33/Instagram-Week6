//
//
//import UIKit
//import Parse
//
//class TableViewController: UITableViewController {
//    
//    var usernames = [""]
//    var userids = [""]
////    var isFollowing = ["":false]
//    
//    var refresher: UIRefreshControl!
//    
//    func refresh() {
//        
//        var query = PFUser.query()
//        
//        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
//            
//            if let users = objects {
//                
//                self.usernames.removeAll(keepCapacity: true)
//                self.userids.removeAll(keepCapacity: true)
//                
//                for object in users {
//                    
//                    if let user = object as? PFUser {
//                        
//                        if user.objectId! != PFUser.currentUser()?.objectId {
//                            
//                            self.usernames.append(user.username!)
//                            self.userids.append(user.objectId!)
//                            
//                            self.tableView.reloadData()
//                            self.refresher.endRefreshing()
//                        }
//                    }
//                    
//                }
//                
//            }
//        })
//    }
//
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        refresher = UIRefreshControl()
//        
//        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        
//        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
//        
//        self.tableView.addSubview(refresher)
//        
//        refresh()
//        
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    // MARK: - Table view data source
//    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return usernames.count
//    }
//    
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
//        
//        cell.textLabel?.text = usernames[indexPath.row]
//        
////        let followedObjectId = userids[indexPath.row]
//        
////        if isFollowing[followedObjectId] == true {
//        
////            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//        
////        }
//        
//        
//        return cell
//    }
//    
//    
////    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
////        
////        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
////        
////        let followedObjectId = userids[indexPath.row]
////        
////        if isFollowing[followedObjectId] == false {
////            
////            isFollowing[followedObjectId] = true
////            
////            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
////            
////            var following = PFObject(className: "followers")
////            following["following"] = userids[indexPath.row]
////            following["follower"] = PFUser.currentUser()?.objectId
////            
////            following.saveInBackground()
////            
////        } else {
////            
////            isFollowing[followedObjectId] = false
////            
////            cell.accessoryType = UITableViewCellAccessoryType.None
////            
////            var query = PFQuery(className: "followers")
////            
////            query.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
////            query.whereKey("following", equalTo: userids[indexPath.row])
////            
////            query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
////                
////                if let objects = objects {
////                    
////                    for object in objects {
////                        
////                        object.deleteInBackground()
////                        
////                    }
////                }
////                
////                
////            })
////            
////            
////            
////        }
////        
////    }
//}




















//
//  TableViewController.swift
//  instagram
//
//  Created by Majid Rahimi on 3/7/16.
//  Copyright © 2016 Majid Rahimi. All rights reserved.
//

import UIKit
import Parse


class TableViewController: UITableViewController {
    
    var messages = [String]()
    var usernames = [String]()
    var imageFiles = [PFFile]()
    var users = [String: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var query = PFUser.query()
        
        query?.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
            
            if let users = objects {
                
//                self.messages.removeAll(keepCapacity: true)
//                self.users.removeAll(keepCapacity: true)
//                self.imageFiles.removeAll(keepCapacity: true)
//                self.usernames.removeAll(keepCapacity: true)
                
                for object in users {
                    
                    if let user = object as? PFUser {
                        
                        self.users[user.objectId!] = user.username!
                        print(users)
                        
                    }
                }
                
                
            }
            
            
//            var getFollowedUsersQuery = PFQuery(className: "followers")
//            
//            getFollowedUsersQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
//            
//            getFollowedUsersQuery.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//                
//                if let objects = objects {
//                    
//                    for object in objects {
//                        
//                        var followedUser = object["following"] as! String
//                        
//                        var query = PFQuery(className: "Post")
//                        
//                        query.whereKey("userId", equalTo: followedUser)
            
            
            
                        let query = PFQuery(className: "Post")
                        query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                            
                            if let objects = objects {
                                
                                for object in objects {
            
                                    self.messages.append(object["message"] as! String)
                                    
                                    self.imageFiles.append(object["imageFile"] as! PFFile)
                                    
                                    self.usernames.append(object[self.users["objectId"]!] as! String)
                                    
                                    self.tableView.reloadData()
                                    
                                }
            
                            }
            
                            
                        })
//                    }
//                    
//                }
//                
//            }
            
        })
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        
        return imageFiles.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! Cell
        
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data, error) -> Void in
            
            if let downloadedImage = UIImage(data: data!) {
                
                myCell.postedImage.image = downloadedImage
                
            }
            
        }
        
        
        
        myCell.username.text = usernames[indexPath.row]
        
        myCell.message.text = messages[indexPath.row]
        
        return myCell
    }
    


}
