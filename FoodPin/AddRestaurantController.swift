//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Liao Jiue-Ren on 11/06/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var photoImageView : UIImageView!
    
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var typeTextField:UITextField!
    @IBOutlet var locationTextField:UITextField!
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    
    
    @IBAction func toggleButtonColorChange(sender : UIButton)
    {
        if sender == yesButton
        {
            
        }
        else if sender == noButton
        {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imgCtrl = UIImagePickerController()
                imgCtrl.allowsEditing = false
                imgCtrl.sourceType = .photoLibrary
                imgCtrl.delegate = self
                present(imgCtrl, animated: true, completion: nil)
            }
        }
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: UIImagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let selectedImg = info[UIImagePickerControllerOriginalImage] as? UIImage{
            photoImageView.image = selectedImg
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
            
            let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            leadingConstraint.isActive = true
            
            let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            trailingConstraint.isActive = true
            
            let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            topConstraint.isActive = true
            
            let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            bottomConstraint.isActive = true

            dismiss(animated: true, completion: nil)
        }
        
        func unwindToHomeScreen(segue:UIStoryboardSegue){
            
        }
        
        
    }

}
