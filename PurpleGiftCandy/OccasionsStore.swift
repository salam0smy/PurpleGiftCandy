//
//  OccasionsStore.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-02.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import Foundation
import Firebase

class OccasionsStore: BaseStore, AuthStoreListener {
    var itemRef: Firebase?
    var listener: OccasionStoreListener?
    var occasions = [Occasion]()
    var eventAttached:Bool = false
    var uid: String?

    override init() {
        super.init()
        self.itemRef = super.ref!.childByAppendingPath("occasions")
        
        
    }
    
    func onAuth(auth: FAuthData) {
        let uid = auth.uid
        attachEvent(uid)
        print(auth)
    }
    
    func setUid(uid: String){
        attachEvent(uid)
    }
    
    func attachEvent(uid: String){
        self.eventAttached = true
        self.uid = uid
        self.itemRef!.queryOrderedByChild("user").queryEqualToValue(uid).observeEventType(.Value, withBlock: { snapshot in
            
            var occasions = [Occasion]()
            
            for item in snapshot.children {
                // convert to occasion and append to array
                occasions.append(Occasion(snapshot: item as! FDataSnapshot))
            }
            
            if let listener = self.listener {
                listener.onOccasionsQuery(occasions)
            }
            
            self.occasions = occasions
        })
    }
    
    func onChildChanged(block: (occasion: Occasion) -> Void){
        self.itemRef!.queryOrderedByChild("user").queryEqualToValue(uid).observeEventType(.ChildChanged, withBlock: { snapshot in
            let occasion = Occasion(snapshot: snapshot)
            block(occasion: occasion)
        })
        self.itemRef!.queryOrderedByChild("user").queryEqualToValue(uid).observeEventType(.ChildAdded, withBlock: { snapshot in
            let occasion = Occasion(snapshot: snapshot)
            block(occasion: occasion)
        })
    }
    
    func save(occasion: Occasion){
        self.itemRef!.childByAutoId().setValue(occasion.toAnyObject())
    }
    
    func appendGift(occasion: Occasion, giftKey: String){
        let ref = self.itemRef!.childByAppendingPath(occasion.key)
        let giftsRef = ref.childByAppendingPath("gifts")
        
        giftsRef.childByAppendingPath(giftKey).setValue(true)
        let count = occasion.giftsCount + 1
        ref.childByAppendingPath("giftsCount").setValue(count)
    }
}


protocol OccasionStoreListener {
    func onOccasionsQuery(occasions: [Occasion]) -> Void
}