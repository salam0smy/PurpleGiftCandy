//
//  ProfileViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
   // MARK: Properties
    var profile: Profile?
    let profileStore = Stores.profileStore
    let imageStore = Stores.imageStore
    var myProfile = true
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //loadSampleUser()
        //setViewVars()
        self.photoImageView.image = self.photoImageView.image?.circle
        
        if let profile = self.profile {
            // show follow instead of logout
            myProfile = false
            self.updateValues(profile)
            self.logoutButton.hidden = true
        }
        else {
            // show my profile
            // show edit
            myProfile = true
            self.followButton.hidden = true
            self.profileStore.getProfile(Stores.auth!.uid, finishProfileBlock: { profile in
                self.profile = profile
                self.updateValues(self.profile!)
            })
        }
    }
    
    
    func setViewVars(){
        self.photoImageView.image = profile?.photo?.circle
        self.followersLabel.text = profile?.getFollowersCountString()
        self.followingLabel.text = profile?.getFollowingCountString()
        self.postsLabel.text = profile?.getPostsCountString()
        navigationItem.title = profile?.name
    }
    
    func updateValues(profile: Profile) -> Void {
        self.followersLabel.text = profile.getFollowersCountString()
        self.followingLabel.text = profile.getFollowingCountString()
        self.postsLabel.text = profile.getPostsCountString()
        navigationItem.title = profile.name.isEmpty ? profile.username : profile.name
        
        if let imgID = profile.photoKey {
            self.imageStore.getImage(imgID, size: .medium, withBlock: { (photo) in
                self.photoImageView.image = photo?.circle
                self.profile?.photo = photo
            })
        }
        updateButton()
        
    }
    
    func updateButton(){
        if self.myProfile {}
        else {
            //self.logoutButton.description = "Follow"
        }
    }
    
    func loadSampleUser(){
        let photo1 = UIImage(named: "default_profile")!
        self.profile = Profile(name: "Salam Alyahya", photo: photo1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutClick(sender: UIButton) {
        
        Stores.authStore.logout()
    }

    @IBAction func followClick(sender: UIButton) {
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
