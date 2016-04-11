//
//  User.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Firebase

struct User {
    let uid: String
    let email: String
    
    // Initialize from Firebase
    init(authData: FAuthData) {
        uid = authData.uid
        email = authData.providerData["email"] as! String
    }
    
    // Initialize from arbitrary data
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
}
