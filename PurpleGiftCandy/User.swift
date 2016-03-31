//
//  User.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit

class User {
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var followersCount: Int
    var followingCount: Int
    var postsCount: Int
    
    // MARK: Initialization
    init?(name: String, photo: UIImage?, followersCount: Int, followingCount: Int, postsCount: Int){
        self.name = name
        self.photo = photo
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.postsCount = postsCount
        
        if self.name.isEmpty {
            return nil
        }
    }
    
    convenience init?(name: String, photo: UIImage?){
        self.init(name: name, photo: photo, followersCount: 0, followingCount: 0, postsCount: 0)
        
        if self.name.isEmpty {
            return nil
        }
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
}
