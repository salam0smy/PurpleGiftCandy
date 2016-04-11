//
//  Occasion.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Firebase

struct Occasion: Any {
    // MARK: Properties
    let title: String
    let dueDate: NSDate
    var photo: UIImage?
    let giftsCount: Int
    let ref: Firebase?
    let key: String!
    let user: String
    let giftKeys: Dictionary<String, Bool>?
    
    // MARK: Initialization
    init?(title: String, dueDate: NSDate, photo: UIImage?, giftsCount: Int, uid: String){
        // Initialize stored properties.
        self.title = title
        self.dueDate = dueDate
        self.photo = photo
        self.giftsCount = giftsCount
        self.key = nil
        self.ref = nil
        self.user = uid
        giftKeys = Dictionary<String, Bool>()
        
        if title.isEmpty {
            return nil
        }
        
    }
    
    init(snapshot: FDataSnapshot){
        self.key = snapshot.key
        self.title = snapshot.value["title"] as! String
        let date = snapshot.value["dueDate"] as! String
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:sssZZZ"
        self.dueDate = dateFormatter.dateFromString(date)!
        self.giftsCount = snapshot.value["giftsCount"] as! Int
        self.ref = snapshot.ref
        self.photo = UIImage(named: "wishlistIcon")
        self.user = snapshot.value["user"] as! String
        self.giftKeys = snapshot.value["gifts"] as? Dictionary<String, Bool>
    }
    

    
    func getDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter.stringFromDate(self.dueDate)
    }
    
    func stringToDate(sDate: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:sssZZZ"
        return dateFormatter.dateFromString(sDate)
    }
    
    
    func toAnyObject() -> Dictionary<String, AnyObject>{
        return [
            "title": self.title,
            "dueDate": self.dueDate.description,
            "giftsCount": self.giftsCount,
            "user": self.user
        ]
    }
}
