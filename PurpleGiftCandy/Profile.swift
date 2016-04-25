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
    var user: String
    var photoKey: String?
    
    // MARK: Initialization
    init(name: String, photo: UIImage){
        self.name = name
        self.photo = photo
        self.followersCount = 0
        self.postsCount = 0
        self.followingCount = 0
        self.username = ""
        self.user = ""
    }
    
    init(username: String) {
        self.username = username
        self.followersCount = 0
        self.postsCount = 0
        self.followingCount = 0
        self.name = ""
        self.photo = nil
        self.user = ""
    }
    
    init(snap: FDataSnapshot){
        self.username = snap.value["username"] as! String
        self.followersCount = snap.value["followersCount"] as! Int
        self.postsCount = snap.value["postsCount"] as! Int
        self.followingCount = snap.value["followingCount"] as! Int
        self.name = snap.value["name"] as! String
        self.photo = nil
        self.photoKey = snap.value["photo"] as? String
        self.user = snap.value["user"] as! String
    }
    
    init(snapDictionary: [String: AnyObject]){
        self.username = snapDictionary["username"] as! String
        self.followersCount = snapDictionary["followersCount"] as! Int
        self.postsCount = snapDictionary["postsCount"] as! Int
        self.followingCount = snapDictionary["followingCount"] as! Int
        self.name = snapDictionary["name"] as! String
        self.photo = nil
        self.photoKey = snapDictionary["photo"] as? String
        self.user = snapDictionary["user"] as! String
    }
    
    init(name: String, username: String, photo: UIImage, followersCount: Int, followingCount: Int, postsCount: Int, key: String){
        self.name = name
        self.photo = photo
        self.followersCount = followersCount
        self.postsCount = postsCount
        self.followingCount = followingCount
        self.username = username
        self.user = key
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
            "user": user,
            "name": name,
            "followersCount": 0,
            "followingCount": 0,
            "postsCount": 0,
            "createdAt": utils.toFormattedString(NSDate()),
            "photo": photoKey! ?? ""
        ]
    }
}