//
//  SearchStore.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-10.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import Foundation
import Firebase

class SearchStore: BaseStore {
    var reqRef: Firebase?
    var resRef: Firebase?
    
    override init(){
        super.init()
        self.reqRef = super.ref!.childByAppendingPath("search/request") as Firebase
        self.resRef = super.ref!.childByAppendingPath("search/response") as Firebase
    }
    
    func search(type: String, query: AnyObject, withBlock: (snapshot: FDataSnapshot?)->()){
        let val = [
            "index": "firebase",
            "type": type,
            "query": query
        ]
        
        self.reqRef?.childByAutoId().setValue(val, withCompletionBlock: { (error, ref) in
            print(ref.key)
            self.onSearchResults(ref.key, withBlock: withBlock)
        })
    }
    
    func onSearchResults(searchID: String, withBlock: (snapshot: FDataSnapshot?)->()){
        self.resRef?.childByAppendingPath(searchID).observeEventType(.Value, withBlock: { (snap) in
            if snap.exists() {
                withBlock(snapshot: snap)
            }
        })
//        self.resRef?.childByAppendingPath(searchID).observeSingleEventOfType(.ChildChanged, withBlock: withBlock)
        
    }
}
