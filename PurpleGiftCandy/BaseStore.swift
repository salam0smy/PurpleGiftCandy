//
//  BaseStore.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-02.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Firebase

class BaseStore {
    var ref: Firebase?
    
    init(){
        ref = Firebase(url: "https://incandescent-heat-3647.firebaseio.com")
    }
}
