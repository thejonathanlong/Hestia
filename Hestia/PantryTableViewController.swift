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
    var requestManager : PantryRequestManager = PantryRequestManager()
    var ingredients : [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager.delegate = self
        requestManager.getAllRecipes()
    }
    
    //MARK: - DataRequestManagerDelegate
    func dataRequestManager(_ manager: DataRequestManager, didReceiveResults results: [AnyObject], forQuery query: CKQuery) {
        switch query.recordType {
        case Ingredient.type:
            ingredients = results as! [Ingredient]
            break
        default:
            print("Got an unrecognized record type?? \(query.recordType)")
        }
        
        DispatchQueue.main.async { 
            self.tableView.reloadData()
        }
        
    }
    
    func dataRequestManager(_ manager: DataRequestManager, didReceiveError error: NSError, forQuery query: CKQuery) {
        print("Got an error... \(error)")
    }
    
    func dataRequestManager(_ manager: DataRequestManager, didReceiveSaveError error: NSError) {
        print("Got a save error... \(error)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowPantryItem" {
//            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! PantryItemDetailViewController
//            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//            controller.navigationItem.leftItemsSupplementBackButton = true
//        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pantryItemTableViewCellReuseIdentifier", for: indexPath)
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
