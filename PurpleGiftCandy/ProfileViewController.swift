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
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSampleUser()
        setViewVars()
    }
    
    func setViewVars(){
        self.photoImageView.image = profile?.photo?.circle
        self.followersLabel.text = profile?.getFollowersCountString()
        self.followingLabel.text = profile?.getFollowingCountString()
        self.postsLabel.text = profile?.getPostsCountString()
        navigationItem.title = profile?.name
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
