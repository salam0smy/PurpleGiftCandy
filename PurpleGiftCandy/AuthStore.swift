//
//  AuthStore.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-01.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import Foundation
import Firebase

class AuthStore: BaseStore {
    // MARK: Properties
    var loginListener: AuthStoreListener?
    var logoutListerner: AuthStoreListener?
    
    var onAuths = [AuthStoreListener]()
    static var _auth: Auth?
    var uid: String?
    
    // MARK: Initializer
    override init() {
        super.init()
        super.ref!.observeAuthEventWithBlock { (authData) -> Void in
            // 2
            if authData != nil {
                // 3
                if let login = self.loginListener {
                    login.loginFinishSucessfully()
                    Stores.auth = authData
                    self.uid = "123"
                    for onAuth in self.onAuths {
                        onAuth.onAuth(authData)
                    }
                }
            }
            else {
                if let logout = self.logoutListerner {
                    logout.logoutFinishSuccessfully()
                }
            }
        }
    }
    
    func signup(email: String, password: String, successCallback: (User)->(), errorCallback: (NSError?)->()){
        super.ref!.createUser(email, password: password,
                       withValueCompletionBlock: { error, result in
                        if error != nil {
                            // There was an error creating the account
                            print(error)
                            errorCallback(error)
                        } else {
                            let uid = result["uid"] as? String
                            print("\n\nSuccessfully created user account with uid: \(uid)")
                            print(result)
                            //let profileRef = super.ref!.childByAppendingPath()
                            let user = User(uid: uid!, email: email)
                            successCallback(user)
                            //self.login(email, password: password)
                        }
        })
        
    }
    
    func login(email: String, password: String, finish: (NSError?)->()){
        super.ref!.authUser(email, password: password,
                          withCompletionBlock: { (error, auth) -> Void in
                            // 4
                            Stores.auth = auth
                            finish(error)
        })
    }
    
    
    func onAuth(delegate: AuthStoreListener){
        self.onAuths.append(delegate)
    }
    
    func logout(){
        self.ref!.unauth()
    }
    
}

protocol AuthStoreListener {
    func loginFinishSucessfully() -> Void
    func logoutFinishSuccessfully() -> Void
    func onAuth(auth: FAuthData) -> Void
}

extension AuthStoreListener {
    func loginFinishSucessfully(){}
    func logoutFinishSuccessfully(){}
    func onAuth(auth: FAuthData) {}
}

struct Auth {
    var auth: FAuthData
}