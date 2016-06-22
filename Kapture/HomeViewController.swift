//
//  HomeViewController.swift
//  Kapture
//
//  Created by Valerie Chen on 6/20/16.
//  Copyright © 2016 Valerie Chen. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var feedTableView: UITableView!
    var isMoreDataLoading = false
    
    var loadLimit = 20
    var posts = [PFObject]?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedTableView.dataSource = self
        feedTableView.delegate = self
        makeQuery()
        
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        feedTableView.insertSubview(refreshControl, atIndex: 0)
        
        //feedTableView.estimatedRowHeight = 100
        //chatTableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeQuery() {
        let query = PFQuery(className: "Post")
        // query.includeKey("media")
        // query.includeKey("caption")
        query.includeKey("author")
        query.orderByDescending("createdAt")
        query.limit = loadLimit
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) in
            if error == nil {
                print("Successfully retrieved messages")
                if let objects = objects {
                    self.posts = objects
                    self.feedTableView.reloadData()
                }
            } else {
                print(error)
            }
        }
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        makeQuery()
        
        // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
    }
    
    func loadMoreData() {
        loadLimit += 20
        makeQuery()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = feedTableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - feedTableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && feedTableView.dragging) {
                
                isMoreDataLoading = true
                
                // Code to load more results
                loadMoreData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let posts = posts {
            return posts.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = feedTableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        print("num: \(posts!.count), this: \(indexPath.row)\n")
        cell.gramPost = posts![indexPath.row]
//        if let image = posts![indexPath.row]["media"] as? UIImage {
//            cell.photoView.image = image
//        }
//        if let caption = posts![indexPath.row]["caption"] as? String {
//            cell.captionLabel.text = caption
//        }
//        if let user = posts![indexPath.row]["_p_author"] as? PFUser {
//            cell.userLabel.text = user.username
//        }
        return cell
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
