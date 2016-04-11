//
//  ViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit

class ViewController: UITabBarController, AuthStoreListener {
    var button :UIButton!
    var isHighLighted: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let photo1 = UIImage(named: "icon_gift_btn")!
        addCenterButtonWithImage(photo1, highlightImage: photo1)
        Stores.authStore.logoutListerner = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCenterButtonWithImage(buttonImage: UIImage, highlightImage:UIImage?)
        
    {
        
        let frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height)
        
        button = UIButton(frame: frame)
        
        button.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        
        button.setBackgroundImage(highlightImage, forState: UIControlState.Highlighted)
        
        let heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        
        if heightDifference < 0 {
            
            button.center = self.tabBar.center;
            
        }
            
        else
            
        {
            
            var center:CGPoint = self.tabBar.center;
            
            center.y = center.y - heightDifference/2.0;
            
            button.center = center;
            
        }
        
        button.addTarget(self, action: #selector(ViewController.changeTabToMiddleTab(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(button)
        
    }
    
    func logoutFinishSuccessfully() {
        performSegueWithIdentifier("loginSegue", sender: nil)
    }
    
    func changeTabToMiddleTab(sender:UIButton)
        
    {
        print("click")
        let selectedIndex = Int(self.viewControllers!.count/2)
        
        self.selectedIndex = selectedIndex
        
        self.selectedViewController = (self.viewControllers as [AnyObject]?)?[selectedIndex] as? UIViewController
        
        dispatch_async(dispatch_get_main_queue(), {
            
            if self.isHighLighted == false{
                
                sender.highlighted = true;
                
                self.isHighLighted = true
                
            }else{
                
                sender.highlighted = false;
                
                self.isHighLighted = false
                
            }
            
        });
        
        sender.userInteractionEnabled = false
        
    }
    
   
    
   
    //MARK: TABBAR DELEGATE
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        // TODO: change type of controller to middle controller
        if !viewController.isKindOfClass(FeedsTableViewController) || !viewController.isKindOfClass(OccasionsTableViewController)
            
        {
            
            button.userInteractionEnabled = true
            
            button.highlighted = false
            
            button.selected = false
            
            isHighLighted = false
            
        }
            
        else {
            
            button.userInteractionEnabled = false
            
        }
        
    }


}

