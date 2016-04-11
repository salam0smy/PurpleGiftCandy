//
//  FriendsTableViewController.swift
//  PurpleGiftCandy
//
//  Created by Salam alyahya on 2016-03-29.
//  Copyright © 2016 Salam alyahya. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var profiles = [Profile]()
    var searchProfiles: [Profile]?
    var isSearch = false
    let profileStore = Stores.profileStore
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadSampleFriends()
        
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        
    }
    
    func loadSampleFriends(){
        for _ in 0..<4 {
            let photo1 = UIImage(named: "default_profile")!
            let profile = Profile(name: "Salam Yahya", photo: photo1)
            profiles.append(profile)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isSearch ? self.searchProfiles!.count : self.profiles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "FriendsTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FriendsTableViewCell
        let user = self.isSearch ? searchProfiles![indexPath.row] : profiles[indexPath.row]
        cell.nameLabel.text = user.name.isEmpty ? user.username : user.name
        cell.photoImageView.image = user.photo?.circle
        // Configure the cell...

        return cell
    }
    
    func filterContentForSearchText(searchText: String) {
        
        if !searchText.isEmpty{
            // Filter the array using the filter method
            self.isSearch = true
            self.profileStore.searchForProfile(searchText, withBlock: {(resProfiles) in
                
                self.searchProfiles = resProfiles
                self.tableView.reloadData()
            })
        }
        else {
            //self.isSearch = false
            //self.tableView.reloadData()
            self.searchProfiles = []
            self.tableView.reloadData()
        }
        
        
        
    
    }
    
//    func searchController(controller: UISearchController, shouldReloadTableForSearchString searchString: String?) -> Bool {
//        filterContentForSearchText(searchString!)
//        
//        return true
//    }
    
    
    
    //func searchController(controller: UISearchController, shouldC)
    
    


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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Search
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.isSearch = false
        self.tableView.reloadData()
    }

}
