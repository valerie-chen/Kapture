//
//  MyPhotoCell.swift
//  Kapture
//
//  Created by Valerie Chen on 6/22/16.
//  Copyright © 2016 Valerie Chen. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MyPhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: PFImageView!
    var timeStamp: String = ""
    
    var gramPost: PFObject! {
        didSet {
            self.photoView.file = gramPost["media"] as? PFFile
            // self.timeStamp = gramPost["_created_at"] as! String
            self.photoView.loadInBackground()
        }
    }
    
}
