//
//  OccasionViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit

class OccasionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate , UIImagePickerControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var privacyPickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    var occasion: Occasion?
    
    let privacyOptions = ["Public", "Private"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.privacyPickerView.delegate = self
        self.privacyPickerView.dataSource = self
        self.nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let occasion = occasion {
            nameTextField.text = occasion.title
        }
        
        checkValidName()
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
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidName() {
        // Disable the Save button if the text field is empty.
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let date = datePicker.date
            let photo1 = UIImage(named: "wishlistIcon")!
            // Set the meal to be passed to MealTableViewController after the unwind segue.
            let uid = Stores.auth?.uid
            occasion = Occasion(title: name, dueDate: date, photo: photo1, giftsCount: 0, uid: uid!)
        }
    }
    
    // MARK: Navigation

    @IBAction func cancel(sender: UIBarButtonItem) {
        print("cancel")
         dismissViewControllerAnimated(true, completion: nil)
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
//        let isPresentingInAddMealMode = presentingViewController is UINavigationController
//        if isPresentingInAddMealMode {
//            dismissViewControllerAnimated(true, completion: nil)
//        }
//        else{
//            navigationController!.popViewControllerAnimated(true)
//        }
    }

    
    // MARK: DatePicker
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return privacyOptions.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return privacyOptions[row]
    }

}
