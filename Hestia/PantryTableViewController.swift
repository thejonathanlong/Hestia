//
//  PantryTableViewController.swift
//  Hestia
//
//  Created by Jonathan Long on 4/13/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

class PantryTableViewController: UITableViewController, DataRequestManagerDelegate {
    var companionViewController : PantryItemDetailViewController?
    var requestManager : DataRequestManager = DataRequestManager()
    var recipes : [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager.delegate = self
        requestManager.getAllRecipes()
    }
    
    //MARK: - DataRequestManagerDelegate
    func dataRequestManager(manager: DataRequestManager, didReceiveResults results: [AnyObject], forQuery query: CKQuery) {
        switch query.recordType {
        case RecipeType:
            recipes = results as! [Recipe]
            break
        default:
            print("Got an unrecognized record type?? \(query.recordType)")
        }
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.tableView.reloadData()
        }
        
    }
    
    
    
    func dataRequestManager(manager: DataRequestManager, didReceiveError error: NSError, forQuery query: CKQuery) {
        print("Got an error... \(error)")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "ShowPantryItem" {
//            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PantryItemDetailViewController
//            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//            controller.navigationItem.leftItemsSupplementBackButton = true
//        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pantryItemTableViewCellReuseIdentifier", forIndexPath: indexPath)
        let recipe = recipes[indexPath.row]
        cell.textLabel?.text = recipe.name

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let selectedMonster = self.monsters[indexPath.row]
//        self.delegate?.monsterSelected(selectedMonster)
        
//        if let detailViewController = self.delegate as? DetailViewController {
        if let detailViewController = companionViewController {
            splitViewController?.showDetailViewController(detailViewController.navigationController!, sender: nil)
        }
//        }
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

}
