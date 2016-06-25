//
//  CaptureViewController.swift
//  Kapture
//
//  Created by Valerie Chen on 6/20/16.
//  Copyright © 2016 Valerie Chen. All rights reserved.
//

import UIKit
import MBProgressHUD

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var captionView: UITextView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choosePhotoButton.layer.borderWidth = 1
        choosePhotoButton.layer.borderColor = UIColor.blackColor().CGColor
        // let stringColorAttributes = [ NSForegroundColorAttributeName: UIColor.grayColor() ]
        choosePhotoButton.layer.borderWidth = 3
        captionView.layer.borderWidth = 1
        captionView.layer.borderColor = UIColor.grayColor().CGColor
        // captionField.attributedPlaceholder = NSAttributedString(string: "Write a caption...", attributes: stringColorAttributes)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapButton(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func onShare(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Post.postUserImage(photoView.image, withCaption: captionView.text) { (success: Bool, error: NSError?) in
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            //redirect to home page
            self.photoView.image = nil
            self.captionView.text = ""
            self.photoView.reloadInputViews()
            self.tabBarController?.selectedIndex = 0
            // self.performSegueWithIdentifier("returnHomeSegue", sender: nil)
            //perhaps a window pops up saying posted?
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        choosePhotoButton.setTitle("", forState: UIControlState.Normal)
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoView.image = tempImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
    }

}
