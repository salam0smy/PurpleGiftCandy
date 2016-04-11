//
//  OccasionGiftCollectionViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-06.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import Dollar

private let reuseIdentifier = "occasionGiftCell"

class OccasionGiftCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Properties
    var occasion: Occasion! {
        didSet(val){
            updateKeys()
        }
    }
    var gifts: [String:Gift] = [:]
    var keys: [String]! = []
    let giftStore = Stores.giftStore
    let imageStore = Stores.imageStore

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(OccasionGiftCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        self.navigationItem.title = occasion.title
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateKeys(){
        if let giftKeys = occasion.giftKeys {
            let keys = giftKeys.map {"\($0.0)"} // get a string array for keys
            let diff = $.xor(self.keys, keys)
            registerGiftEvents(diff)
            self.keys.appendContentsOf(diff)
        }
        
    }
    
    func registerGiftEvents(keys: [String]){
        let updateBlock = {(gift: (key: String, value:Gift))->() in
            self.gifts[gift.key] = gift.value
            self.collectionView?.reloadData()
        }
        for key in keys {
            giftStore.registerGiftsEvent(key, withBlock: updateBlock)
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showGiftDetails" {
            if let controller = segue.destinationViewController as? MyGiftViewController, cell = sender as? OccasionGiftCollectionViewCell{
                let indexPath = self.collectionView?.indexPathForCell(cell)
                let i = indexPath!.row
                let key = self.keys[i]
                if let gift = self.gifts[key] {
                    controller.gift = gift
                }
            }
        }
        
    }
 
    
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifts.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! OccasionGiftCollectionViewCell
        
        // Configure the cell
        let i = indexPath.row
        let key = self.keys[i]
        // TODO: fill empty item with loading item
        if var gift = self.gifts[key] {
            cell.lebel.text = gift.title
            
            if let photo = gift.photoKey {
                imageStore.getImage(photo, size: .medium) { (photo: UIImage?) in
                    gift.photo = photo!
                    cell.photoImageView.image = photo
                }
            }

        }
        
        return cell
    }
    
//    override func viewWillLayoutSubviews() {
//        self.collectionView?.collectionViewLayout.invalidateLayout()
//    }
    // MARK: UICollectionViewDelegate
    
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    //Mark: UICollectionViewDelegateFlowLayout
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        // Configure the cell
//        let i = indexPath.row
//        let key = self.keys[i]
//        let gift = self.gifts[key]!
//        let imgSize = gift.photo.size
//        
//        return CGSizeMake(imgSize.width, imgSize.height+100)
//    }

}
