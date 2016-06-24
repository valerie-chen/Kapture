//
//  DetailsViewController.swift
//  Kapture
//
//  Created by Valerie Chen on 6/22/16.
//  Copyright © 2016 Valerie Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var username: String = ""
    var timeStamp: String = ""
    var caption: String = ""
    var photoViewTemp: PFFile?
    
    var gramPost: PFObject! {
        didSet {
            self.photoView.file = gramPost["media"] as? PFFile
            self.photoView.loadInBackground()
            self.usernameLabel.text = gramPost["author"].username
            self.timeStampLabel.text = timeStamp
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoView.file = photoViewTemp
        self.photoView.loadInBackground()
        self.usernameLabel.text = username
        self.captionLabel.text = caption
        self.timeStampLabel.text = timeStamp
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
