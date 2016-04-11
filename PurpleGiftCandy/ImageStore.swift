//
//  ImageStore.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-08.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import Foundation
import Firebase
import Dollar
import Toucan

class ImageStore: BaseStore {
    
    // MARK: Properties
    var itemRef: Firebase?
    
    // MARK: Initializer
    override init(){
        super.init()
        self.itemRef = super.ref!.childByAppendingPath("images")
    }
    
    // MARK: Firebase events
    func writeImage(photo: UIImage, ext:String, user: String, withBlock: (String?)->()){
        // create 3 different thumbnails and upload them
        // image lare has max width
        let lgPhoto = resizeImage(photo, size: .large)
        let mdPhoto = resizeImage(photo, size: .medium)
        let smPhoto = resizeImage(photo, size: .small)
        let photos = ["large": lgPhoto, "medium": mdPhoto, "small": smPhoto]
        let ref = self.itemRef?.childByAutoId()
        let imgRef = ref?.childByAppendingPath("thumnails")
        let info = ["user": user, "created": NSDate.description()]
        
        ref!.setValue(info)
        
        photos.forEach { (key, photo) in
            let base64String = convertTo64BaseString(photo, ext: ext)
            imgRef?.childByAppendingPath(key)
                .setValue(base64String, withCompletionBlock: { (err, ref) in
                    if err != nil {
                        print(err)
                    }
                })
        }
        
        withBlock(ref?.key)
        
    }
    
    func getImage(key: String, size: ThumnailSize, withBlock: (UIImage?)->Void){
        let ref = self.itemRef?.childByAppendingPath(key).childByAppendingPath("thumnails")
        let block = {(snapshot: FDataSnapshot!) -> Void in
            let imgString = snapshot.value as! String
            let photo = self.convertFrom64BaseString(imgString)
            withBlock(photo)
        }
        
        switch size {
        case .large:
            ref?.childByAppendingPath("large").observeEventType(.Value, withBlock: block)
            break
        case .medium:
            ref?.childByAppendingPath("medium").observeEventType(.Value, withBlock: block)
            break
        default:
            ref?.childByAppendingPath("small").observeEventType(.Value, withBlock: block)
        }
    }
    
    //MARK: Base64 conversion methods
    
    func convertTo64BaseString(photo: UIImage, ext: String) -> String {
        let imgData:NSData!
        
        if ext == "JPG" {
            
            imgData = UIImageJPEGRepresentation(photo, 1)
        }
        else {
            imgData = UIImagePNGRepresentation(photo)!
        }
        return imgData.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
    
    func convertFrom64BaseString(base64String: String) -> UIImage?{
        
        let decodedData = NSData(base64EncodedString: base64String, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        return UIImage(data: decodedData!)
    }
    
    // MARK: size methods
    
    func resizeImage(photo: UIImage, size: ThumnailSize) -> UIImage{
        let msize = getSize(size)
        return Toucan(image: photo).resize(msize, fitMode: .Clip).image
    }
    
    func getSize(size: ThumnailSize) -> CGSize{
        //determin the size
        let _size:CGSize?
        switch size {
        case .large:
            _size = CGSize(width: 500, height: 500)
            break
        case .medium:
            _size = CGSize(width: 200, height: 200)
            break
        default:
            _size = CGSize(width: 90, height: 90)
        }
        
        return _size!
    }
    
}


enum ThumnailSize {
    case large
    case medium
    case small
}