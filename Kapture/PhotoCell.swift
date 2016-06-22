//
//  PhotoCell.swift
//  Kapture
//
//  Created by Valerie Chen on 6/20/16.
//  Copyright © 2016 Valerie Chen. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class PhotoCell: UITableViewCell {

    @IBOutlet weak var photoView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var gramPost: PFObject! {
        didSet {
            self.photoView.file = gramPost["media"] as? PFFile
            let user = gramPost["author"] as! PFUser
            self.userLabel.text = user.username! as String
            self.captionLabel.text = gramPost["caption"] as? String
            self.photoView.loadInBackground()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
