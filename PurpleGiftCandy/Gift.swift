//
//  Gift.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Firebase

struct Gift {
    // MARK: Properties
    let title: String
    var photo: UIImage
    var occasion: Occasion?
    var price: Double
    var description: String?
    var seller: String?
    var _occasions: Dictionary<String, Bool>
    var occasions: [Occasion]
    var user: String
    var photoKey: String?
    
    // MARK: Initialization
    init(snapshot: FDataSnapshot){
        self.title = snapshot.value["title"] as! String
        self.price = snapshot.value["price"] as! Double
        self.description = snapshot.value["description"] as? String
        self.seller = snapshot.value["seller"] as? String
        self.user = snapshot.value["user"] as! String
        self._occasions = snapshot.value["occasions"] as! [String: Bool]
        self.occasions = [Occasion]()
        self.photo = UIImage(named: "defaultPhoto")!
        self.photoKey = snapshot.value["photo"] as? String
    }
    
    
    init(title: String, photo: UIImage, occasion: Occasion?, price: Double, description: String, seller: String, _occasions: [String:Bool], occasions: [Occasion], user: String){
        self.title = title
        self.photo = photo
        self.occasion = occasion
        self.price = price ?? 0
        self.occasions = occasions
        self.seller = seller
        self.user = user
        self._occasions = _occasions
        self.description = description
    }
    
    mutating func removeOccasion(occasionId: String){
        self._occasions.removeValueForKey(occasionId)
    }
    
    func toAnyObject() -> Dictionary<String, AnyObject> {
        return [
            "title": self.title,
            "price": self.price,
            "description": self.description ?? "",
            "seller": self.seller ?? "",
            "occasions": self._occasions,
            "user": self.user,
            "photo": self.photoKey ?? ""
        ]
    }
    
}
