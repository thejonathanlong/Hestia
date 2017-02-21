//
//  IngredientSelectionCollectionViewController.swift
//  Hestia
//
//  Created by Jonathan Long on 2/15/17.
//  Copyright © 2017 Hiro. All rights reserved.
//

import UIKit

private let reuseIdentifier = "IngredientCell"
private let supplementaryReuseIdentifier = "SectionView"

class IngredientSelectionCollectionViewController: UICollectionViewController {
	
	var ingredients : [String: [String]]?
	var ingredientTypes : [String] = ["Produce", "Spices", "Other"]
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

		ingredients = [
			"Produce" : ["tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe"],
		               "Spices" : ["tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe"],
		               "Other" : ["tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe","tomatoe1", "tomatoe2", "tomatoe3", "tomatoe4", "tomatoe5", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe", "tomatoe"]]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.ingredientTypes.count
    }
	
	override public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: supplementaryReuseIdentifier, for: indexPath)
		for view in sectionHeader.subviews {
			view.removeFromSuperview()
		}
		let label = UILabel()
		
		label.translatesAutoresizingMaskIntoConstraints = false
		sectionHeader.addSubview(label)
		label.leftAnchor.constraint(equalTo: sectionHeader.leftAnchor).isActive = true
		label.rightAnchor.constraint(equalTo: sectionHeader.rightAnchor).isActive = true
		label.topAnchor.constraint(equalTo: sectionHeader.topAnchor).isActive = true
		label.bottomAnchor.constraint(equalTo: sectionHeader.bottomAnchor).isActive = true
		
		label.text = ingredientTypes[indexPath.section]
		return sectionHeader
	}


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let ing = ingredients else { return 0 }
		guard let ingredientList = ing[ingredientTypes[section]] else { return 0 }
		return ingredientList.count
		
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
		let label = UILabel()
	
		label.translatesAutoresizingMaskIntoConstraints = false
		cell.contentView.addSubview(label)
		label.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor).isActive = true
		label.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor).isActive = true
		label.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
		label.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
		
		//		cell.layer.cornerRadius = 25
		//		cell.backgroundColor = UIColor.blue
		cell.contentView.backgroundColor = UIColor.blue
		cell.contentView.layer.cornerRadius = 25
		
		guard let ing = ingredients else { return cell }
		guard let ingredientList = ing[ingredientTypes[indexPath.section]] else { return cell}
		label.text = ingredientList[indexPath.row]
		
		return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
