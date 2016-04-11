//
//  MyGiftViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-04-09.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit
import ChameleonFramework

class MyGiftViewController: UIViewController {
    
    var gift: Gift? = nil
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var sellerLabel: UILabel!
    let imageStore = Stores.imageStore

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let gift = self.gift {
            self.navigationItem.title = gift.title
            if let photo = gift.photoKey {
                imageStore.getImage(photo, size: .large) { (photo: UIImage?) in
                    self.photoImageView.image = photo
                    self.navigationController?.navigationBar.barTintColor = AverageColorFromImage(photo!)
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
