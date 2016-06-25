//
//  ProfileViewController.swift
//  Kapture
//
//  Created by Valerie Chen on 6/20/16.
//  Copyright © 2016 Valerie Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import DateTools

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var myNavigationItem: UINavigationItem!
    @IBOutlet weak var profilePicView: UIImageView!
    
    var isMoreDataLoading = false
    var loadLimit = 20
    var posts = [PFObject]?()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        // self.title = PFUser.currentUser()?.username
        myNavigationItem.title = PFUser.currentUser()?.username
        makeQuery()
        
        profilePicView.layer.borderWidth = 1.0
        profilePicView.layer.masksToBounds = false
        profilePicView.layer.borderColor = UIColor.blueColor().CGColor
        profilePicView.layer.cornerRadius = profilePicView.frame.size.width/2
        profilePicView.clipsToBounds = true
        
        collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        collectionView.reloadData()
    }
    
    func makeQuery() {
        let user = PFUser.currentUser()
        let query = PFQuery(className: "Post")
        query.whereKey("author", equalTo: "_User$\(user!.objectId!)")
        // query.includeKey("caption")
        query.orderByDescending("createdAt")
        query.limit = loadLimit
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                if let objects = objects {
                    self.posts = objects
                    // print(self.posts?.count)
                    self.collectionView.reloadData()
                }
            } else {
                print(error)
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = collectionView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - collectionView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && collectionView.dragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadMoreData()
            }
        }
    }
    
    func loadMoreData() {
        loadLimit += 20
        makeQuery()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyPhotoCell", forIndexPath: indexPath) as! MyPhotoCell
        print(posts?.count)
        cell.gramPost = posts![indexPath.item] //COULD BE WRONG
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let totalwidth = collectionView.bounds.size.width;
        let numberOfCellsPerRow = 3
        let dimensions = CGFloat(Int(totalwidth) / numberOfCellsPerRow)
        return CGSizeMake(dimensions, dimensions)
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) in
            // PFUser.currentUser() will now be nil
            self.performSegueWithIdentifier("logoutSegue", sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailsSegue" {
            let cell = sender as! MyPhotoCell
            if let indexPath = collectionView.indexPathForCell(cell) {
                let detailsController = segue.destinationViewController as! DetailsViewController
                let post = cell.gramPost
                let user = PFUser.currentUser()
                detailsController.username = user!.username! as String
                //print(post["caption"])
                detailsController.caption = post["caption"] as! String
                let postDate = post.createdAt
                let timeAgoDate = NSDate.timeAgoSinceDate(postDate)
                detailsController.timeStamp = timeAgoDate //(post.createdAt?.description)!
                detailsController.photoViewTemp = (cell.gramPost["media"] as? PFFile)!
                collectionView.deselectItemAtIndexPath(indexPath, animated: true)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
