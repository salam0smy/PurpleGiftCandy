//
//  GiftStore.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-03.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import Foundation
import Firebase

class GiftStore: BaseStore {
    var itemRef: Firebase?
    
    override init(){
        super.init()
        self.itemRef = super.ref!.childByAppendingPath("gifts")
        
    }
    
    func save(gift: Gift){
        self.itemRef!.childByAutoId().setValue(gift.toAnyObject()) { (error, ref) in
            print(ref)
            let key = ref.key
            for occasion in gift.occasions {
                Stores.occasionStore.appendGift(occasion, giftKey: key)
            }
        }
    }
    
    func registerGiftsEvent(key: String, withBlock: (gift: (key: String, value: Gift))->()){
        // query gift for key
        // perse gift
        // call callback with collection
            self.itemRef!.childByAppendingPath(key).observeEventType(.Value, withBlock: { snapshot in
                //let occasion = Occasion(snapshot: snapshot)
                //block(occasion: occasion)
                let gift = Gift(snapshot: snapshot)
                let key = snapshot.key
                withBlock(gift: (key: key, value: gift))
            })
    }

}