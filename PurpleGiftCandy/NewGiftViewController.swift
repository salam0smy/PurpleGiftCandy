//
//  NewGiftViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-31.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Dollar


class NewGiftViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    // MARK: Properties
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var sellerTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    
    var gift: Gift?
    let giftStore = Stores.giftStore
    let imageStore = Stores.imageStore
    var selectedImage: (ext:String, photo:UIImage)? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Handle the text field’s user input through delegate callbacks.
        titleTextField.delegate = self
        descriptionTextField.delegate = self
        sellerTextField.delegate = self
        priceTextField.delegate = self
        checkValidTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        nextBarButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //mealNameLabel.text = textField.text
        checkValidTitle()
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgRefUrl = info[UIImagePickerControllerReferenceURL] as? NSURL
        
        let urlcomponents = NSURLComponents(URL: imgRefUrl!, resolvingAgainstBaseURL: false)
        let queryItems = (urlcomponents?.queryItems)! as [NSURLQueryItem]
        let query = $.find(queryItems) { $0.name == "ext" }
        //queryItems.
        print("\n\nType: \(dump(query!.value!))")
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        self.selectedImage = (ext: query!.value!, photo: selectedImage)
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        titleTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func checkValidTitle() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        nextBarButton.enabled = !text.isEmpty
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "selectOccasion" {
            let occasionsController = segue.destinationViewController as! OccasionsTableViewController
            let user = Stores.auth?.uid
            self.gift = Gift(title: self.titleTextField.text!, photo: self.photoImageView.image!, occasion: nil, price: Double(self.priceTextField.text!)!, description: self.descriptionTextField.text!, seller: self.sellerTextField.text!, _occasions: [:], occasions: [], user: user!)
            
            
            occasionsController.gift = self.gift
                
            
        }
    }
 
    @IBAction func unwindToNewGift(sender: UIStoryboardSegue) {
        if let occasionsController = sender.sourceViewController as? OccasionsTableViewController {
            var gift = occasionsController.gift
            
            self.imageStore.writeImage((gift?.photo)!, ext: selectedImage!.ext, user: (gift?.user)!, withBlock: { key in
                gift?.photoKey = key
                self.giftStore.save(gift!)
            })
            
            
            
        }
    }

}
