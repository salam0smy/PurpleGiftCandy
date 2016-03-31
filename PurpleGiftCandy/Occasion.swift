//
//  Occasion.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit

class Occasion {
    // MARK: Properties
    var title: String
    var dueDate: NSDate
    var photo: UIImage?
    var giftsCount: Int
    
    // MARK: Initialization
    init?(title: String, dueDate: NSDate, photo: UIImage?, giftsCount: Int){
        // Initialize stored properties.
        self.title = title
        self.dueDate = dueDate
        self.photo = photo
        self.giftsCount = giftsCount
        
        if title.isEmpty {
            return nil
        }
        
    }
    
    func getDateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        return formatter.stringFromDate(dueDate)
    }
}
