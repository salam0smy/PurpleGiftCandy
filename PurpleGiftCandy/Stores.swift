//
//  Stores.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-02.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Firebase

class Stores {
    static let imageStore = ImageStore()
    static let searchStore = SearchStore()
    static let authStore = AuthStore()
    static let occasionStore = OccasionsStore()
    static let giftStore = GiftStore()
    static var auth: FAuthData? = nil
    static let profileStore = ProfileStore()
    
    
    
    private init() {}
}
