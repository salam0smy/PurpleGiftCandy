//
//  ProfileStore.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-04.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import Foundation
import Firebase


class ProfileStore: BaseStore {
    var itemRef: Firebase?
    let searchStore: SearchStore = Stores.searchStore
    
    override init(){
        super.init()
        self.itemRef = super.ref!.childByAppendingPath("profiles")
        
        
    }
    
    func createProfile(username: String, profile: Profile, block: ((NSError?)->(Void))){
        let ref = self.itemRef!.childByAppendingPath(username)
        ref.setValue(profile.toAnyObject()) { (error, ref) in
            block(error)
        }
    }
    
    
    func checkUsernameExists(username: String, exists: (Bool)->()){
        let finishBlock = { (snap:FDataSnapshot)->() in
            exists(snap.exists())
        }
        self.getProfile(username, finishBlock: finishBlock)
    }
    
    func getProfile(username: String, finishBlock: (FDataSnapshot)->()) {
        let ref = self.itemRef!.childByAppendingPath(username)
        ref.observeSingleEventOfType(.Value, withBlock: { snap in
            // The value is null
            finishBlock(snap)
        })
    }
    
    func getProfile(withUserId: String, finishProfileBlock: (Profile)->()) {
        self.itemRef!.queryOrderedByChild("user").queryEqualToValue(withUserId).queryLimitedToFirst(1).observeEventType(.Value, withBlock: { snapshot in
            for snap in snapshot.children{
                if let item = snap as? FDataSnapshot {
                    let profile = Profile(snap: item)
                    finishProfileBlock(profile)
                }
            }
        })
    }
    
    
    func searchForProfile(query: String, withBlock: ([Profile])->()){
        if !query.isEmpty {
            let _query = ["wildcard":["username":"\(query.lowercaseString)*"]]
            
            
            self.searchStore.search("profile", query: _query, withBlock: { (snap:FDataSnapshot?) in
                print(dump(snap?.value))
                if let snap = snap {
                    if (snap.value["total"] as! Int) > 0 {
                        //let totalHits = snap.value["total"] as! Int
                        let hits = snap.value["hits"] as! [AnyObject]
                        var profiles = [Profile]()
                        for hit in hits {
                            profiles.append(Profile(snapDictionary: hit["_source"] as! [String: AnyObject]))
                        }
                        print(profiles)
                        withBlock(profiles)
                    }
                    else {
                        withBlock([])
                    }
                }
                
            })
        }
        
    }
    
    
    
    
}