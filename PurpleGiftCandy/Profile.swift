//
//  Profile.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-04.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Firebase

struct Profile {
    // MARK: Properties
    var name: String
    var username: String
    var photo: UIImage?
    var followersCount: Int
    var followingCount: Int
    var postsCount: Int
    var key: String
    var photoKey: String?
    
    // MARK: Initialization
    init(name: String, photo: UIImage){
        self.name = name
        self.photo = photo
        self.followersCount = 0
        self.postsCount = 0
        self.followingCount = 0
        self.username = ""
        self.key = ""
    }
    
    init(username: String) {
        self.username = username
        self.followersCount = 0
        self.postsCount = 0
        self.followingCount = 0
        self.name = ""
        self.photo = nil
        self.key = ""
    }
    
    init(snap: FDataSnapshot){
        self.username = snap.value["username"] as! String
        self.followersCount = snap.value["followersCount"] as! Int
        self.postsCount = snap.value["postsCount"] as! Int
        self.followingCount = snap.value["followingCount"] as! Int
        self.name = snap.value["name"] as! String
        self.photo = nil
        self.key = snap.value["username"] as! String
        //self.photoKey = snap.value[""]
    }
    
    init(snap: [String: AnyObject]){
        self.username = snap["username"] as! String
        self.followersCount = snap["followersCount"] as! Int
        self.postsCount = snap["postsCount"] as! Int
        self.followingCount = snap["followingCount"] as! Int
        self.name = snap["name"] as! String
        self.photo = nil
        self.key = snap["username"] as! String
        //self.photoKey = snap.value[""]
    }
    
    init(name: String, username: String, photo: UIImage, followersCount: Int, followingCount: Int, postsCount: Int, key: String){
        self.name = name
        self.photo = photo
        self.followersCount = followersCount
        self.postsCount = postsCount
        self.followingCount = followingCount
        self.username = username
        self.key = key
    }
    
    func getFollowingCountString() -> String {
        return "\(self.followingCount) Following"
    }
    
    func getFollowersCountString() -> String {
        return "\(self.followersCount) Followers"
    }
    
    func getPostsCountString() -> String {
        return "\(self.postsCount) Posts"
    }
    
    func toAnyObject() -> Dictionary<String, AnyObject> {
        return [
            "username": username,
            "user": key,
            "name": name,
            "followersCount": 0,
            "followingCount": 0,
            "postsCount": 0,
            "createdAt": NSData().description
        ]
    }
}