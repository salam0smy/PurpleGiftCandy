//
//  Gift.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit

class Gift {
    // MARK: Properties
    var title: String
    var photo: UIImage?
    var occasion: Occasion?
    var price: Double?
    var description: String?
    var seller: String?
    
    // MARK: Initialization
    init(title: String, photo: UIImage?, occasion: Occasion?, price: Double?){
        self.title = title
        self.photo = photo
        self.occasion = occasion
        self.price = price
    }
    
}
