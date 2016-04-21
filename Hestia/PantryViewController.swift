//
//  PantryViewController.swift
//  Hestia
//
//  Created by Jonathan Long on 4/7/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit

class PantryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: Segue Identifiers
    let pantryListSegueIdentifier = "PantryListSegue"
    let possibleRecipesSegue = "possibleRecipesSegue"
    
    //MARK: IBOutlets
    @IBOutlet weak var pantryItemLabel: UILabel!
    @IBOutlet weak var pantryItemImageView: UIImageView!
    
    //MARK properties
    var pantryItemTableViewController : UITableViewController?
    var possibleRecipesCollectionViewController : UICollectionViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier {
            case pantryListSegueIdentifier:
                pantryItemTableViewController = segue.destinationViewController as? UITableViewController
                pantryItemTableViewController?.tableView.delegate = self
                pantryItemTableViewController?.tableView.dataSource = self
                break
            case possibleRecipesSegue:
                possibleRecipesCollectionViewController = segue.destinationViewController as? UICollectionViewController
                possibleRecipesCollectionViewController?.collectionView?.delegate = self
                possibleRecipesCollectionViewController?.collectionView?.dataSource = self
                break
            default:
                print("Couldn't find a segue with identifier \(identifier). Did you set it?")
                break
            }
        }
    }
    
    //MARK: CollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    //MARK: CollectionViewDelegate
    
    //MARK: TableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    //MARK: TableViewDelegate
 

}
