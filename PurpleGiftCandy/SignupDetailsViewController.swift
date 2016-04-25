//
//  SignupDetailsViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-11.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Dollar

class SignupDetailsViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    var profile: Profile?
    var selectedImage: (ext:String, photo:UIImage)? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameTextField.delegate = self
        checkValidName()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let _ = segue.destinationViewController as? LoginViewController {
            let name = self.nameTextField.text!
            self.profile = Profile(name: name, photo: self.photoImageView.image!)
            //controller.profile = self.profile
        }
        
        
    }
 
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveBarButton.enabled = false
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //mealNameLabel.text = textField.text
        checkValidName()
    }
    
    func checkValidName(){
        let text = nameTextField.text ?? ""
        saveBarButton.enabled = !text.isEmpty
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
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }


}
