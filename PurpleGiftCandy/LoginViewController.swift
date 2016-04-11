//
//  LoginViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-31.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import SwiftyButton

class LoginViewController: UIViewController, UITextFieldDelegate, AuthStoreListener {
    
    // MARK: Properties
    let authStore: AuthStore = Stores.authStore
    let profileStore = Stores.profileStore
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var buttonsContainer: UIView!
    var signupButton: (button: SwiftyCustomContentButton, indicator: UIActivityIndicatorView)!
    var loginButton: (button: SwiftyCustomContentButton, indicator: UIActivityIndicatorView)!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        authStore.loginListener = self
        
        setupButtons()
        //setupButtons()
    }
    
    func setupButtons() {
        loginButton = setupButton(buttonsContainer, topPin: buttonsContainer, text: "Login")
        signupButton = setupButton(buttonsContainer, topPin: loginButton.button, text: "Signup")
        
        loginButton.button.autoPinEdge(.Top, toEdge: .Top, ofView: buttonsContainer)
        signupButton.button.autoPinEdge(.Top, toEdge: .Bottom, ofView: loginButton.button)
        
        signupButton.button.addTarget(self, action: #selector(LoginViewController.signup(_:)), forControlEvents: .TouchUpInside)
        loginButton.button.addTarget(self, action: #selector(LoginViewController.login(_:)), forControlEvents: .TouchUpInside)
    }
    
    func setupButton(parent: UIView, topPin: UIView, text: String) -> (button: SwiftyCustomContentButton, indicator: UIActivityIndicatorView) {
        let button = SwiftyCustomContentButton()
        parent.addSubview(button)
    
        //button.autoPinEdge(.Top, toEdge: .Top, ofView: topPin)
        button.autoPinEdge(.Right, toEdge: .Right, ofView: parent)
        button.autoPinEdge(.Left, toEdge: .Left, ofView: parent)
        
        button.buttonColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)
        button.shadowColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1)
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
        button.customContentView.addSubview(indicator)
        indicator.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 0), excludingEdge: .Right)
        //indicator.startAnimating()

        let label = UILabel()
        button.customContentView.addSubview(label)
        label.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10), excludingEdge: .Left)
        label.autoPinEdge(.Left, toEdge: .Right, ofView: indicator, withOffset: 10)
        label.text = text
        label.textColor = UIColor.whiteColor()
        
        return (button, indicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions
    @IBAction func login(sender: UIButton) {
        //startMainApplication()
        self.loginButton.indicator.startAnimating()
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let finish = {(error: NSError?)->() in
            self.loginButton.indicator.stopAnimating()
        }
        authStore.login(email, password: password, finish: finish)
    }
    
    @IBAction func signup(sender: UIButton) {
        self.signupButton.indicator.startAnimating()
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let username = usernameTextField.text!
        let error = {(_error: NSError?) -> () in
            // TODO: handle signup error
            if let err = _error{
                // handle error
                print(err)
                self.signupButton.indicator.stopAnimating()
            }
            else{
                
            }
        }
        let finishLogin = {(_error: NSError?) -> () in
            // TODO: handle signup error
            self.signupButton.indicator.stopAnimating()
            if let err = _error{
                // handle error
                print(err)
            }
            else{
                
            }
        }
        let sucess = {(user: User) -> () in
            // create a profile then login
            let photo1 = UIImage(named: "defaultPhoto")
            let profile = Profile(name: "", username: username, photo: photo1!, followersCount: 0, followingCount: 0, postsCount: 0, key: user.uid)
            self.profileStore.createProfile(username, profile: profile, block: error)
            self.authStore.login(email, password: password, finish: finishLogin)
        }
        let exists = { (exist:Bool) -> () in
            if !exist {
                // if the username doesn't exists, continue with signup
                self.authStore.signup(email, password: password, successCallback: sucess, errorCallback: error)
            }
            else {
                // TODO: show error and let user choose a different username
                print("username already exists")
            }
        }
        
        self.profileStore.checkUsernameExists(username, exists: exists)
        
    }
    
    
    func startMainApplication(){
        performSegueWithIdentifier("startMain", sender: nil)
    }
    
    func loginFinishSucessfully() {
        startMainApplication()
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
