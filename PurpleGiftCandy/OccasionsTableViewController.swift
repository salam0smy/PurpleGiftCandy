//
//  OccasionsTableViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit


class OccasionsTableViewController: UITableViewController, OccasionStoreListener {
    // MARK: Properties
    var occasions = [String:Occasion]()
    var keys = [String: Bool]()
    var onOccasionChanged: [String: (Occasion) -> Void]!
    let occasionsStore:OccasionsStore = Stores.occasionStore
    var selection: Bool = false {
        didSet (val) {
            if selection {
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.rightBarButtonItem = self.saveBarButton
                self.tableView.allowsMultipleSelection = true
            }
            else{
                self.navigationItem.rightBarButtonItem = nil
                self.navigationItem.rightBarButtonItem = self.addBarButton
                self.tableView.allowsMultipleSelection = false
                
            }
        }
    }
    var gift: Gift?
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    //let auth = Stores.authStore.auth

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.allowsSelection = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //loadSampleOccassions()
        //Stores.authStore.onAuth(self.occasionsStore)
        self.occasionsStore.setUid((Stores.auth?.uid)!)
        //self.occasionsStore.listener = self
        //self.occasions = self.occasionsStore.occasions
//        self.occasionsStore.onChildChanged({ occasion in
//            self.updateOccasion(occasion)
//        })
        self.occasionsStore.onChildChanged { (occasion) in
            self.updateOccasion(occasion)
            if let cb = self.onOccasionChanged[occasion.key]{
                cb(occasion)
            }
        }
        
        if let gift = self.gift {
            self.selection = true
            self.saveBarButton.enabled = false
            print(gift)
        }
        else{
            self.selection = false
        }
        self.onOccasionChanged = [:]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.onOccasionChanged.removeAll()
    }
    
    // MARK: OnOccasionsListener
    
    func onOccasionsQuery(occasions: [Occasion]){
        //self.occasions = occasions
        //self.tableView.reloadData()
    }
    
    func updateOccasion(occasion: Occasion) {
//        for (index, _occasion) in self.occasions.enumerate() {
//            if _occasion.key == occasion.key {
//                occasions[index] = occasion
//                break
//            }
//        }
        if let key =  occasion.key {
            self.keys[key] = true
            self.occasions[key] = occasion
        }
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return occasions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "OccasionTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! OccasionTableViewCell
        
        // Configure the cell...
        let keys = [String] (self.occasions.keys)
        let key = keys[indexPath.row]
        if let occasion = self.occasions[key]{
            cell.titleLabel.text = occasion.title
            cell.dueDateLabel.text = occasion.getDateString()
            cell.giftsCountLabel.text = String(occasion.giftsCount)
            cell.photoImageView.image = occasion.photo
        }
        
        
        

        return cell
    }
    
    func setCell(occasion: Occasion, cell: OccasionTableViewCell) -> OccasionTableViewCell{
        cell.titleLabel.text = occasion.title
        cell.dueDateLabel.text = occasion.getDateString()
        cell.giftsCountLabel.text = String(occasion.giftsCount)
        cell.photoImageView.image = occasion.photo
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let keys = [String] (self.occasions.keys)
        let key = keys[indexPath.row]
        let occasion = self.occasions[key]
        
        if self.selection {
            // get selected occasion
            // add occasionid to gift
            
            self.gift?._occasions[key] = true
            self.gift?.occasions.append(occasion!)
            self.saveBarButton.enabled = true
        }
        else {
            // show occasions details and gifts
            performSegueWithIdentifier("occasionsListSegue", sender: indexPath.row)
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // get selected occasion
        // aremove occasionid from gift
        // add occasionid to gift
        let keys = [String] (self.occasions.keys)
        let key = keys[indexPath.row]
        
        self.gift?.removeOccasion(key)
        if self.gift?.occasions.count == 0 {
            self.saveBarButton.enabled = false
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let controller = segue.destinationViewController as? OccasionGiftCollectionViewController {
            let keys = [String] (self.occasions.keys)
            let key = keys[sender as! Int]
            let occasion = self.occasions[key]
            controller.occasion = occasion
            self.onOccasionChanged[occasion!.key] = { (_occasion: Occasion) -> Void in controller.occasion = _occasion }// regiser update event
        }
    }
 
    
    @IBAction func unwindToOccasionList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? OccasionViewController, occasion = sourceViewController.occasion {
            // Add a new meal.
            //let newIndexPath = NSIndexPath(forRow: occasions.count, inSection: 0)
            //occasions.append(occasion)
            //tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            
            self.occasionsStore.save(occasion)
        }
    }

}
