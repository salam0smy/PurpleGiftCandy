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
    var user: User?
    
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
        self.photoImageView.image = user?.photo?.circle
        self.followersLabel.text = user?.getFollowersCountString()
        self.followingLabel.text = user?.getFollowingCountString()
        self.postsLabel.text = user?.getPostsCountString()
        navigationItem.title = user?.name
    }
    
    func loadSampleUser(){
        let photo1 = UIImage(named: "default_profile")!
        self.user = User(name: "Salam Alyahya", photo: photo1)!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
