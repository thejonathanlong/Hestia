//
//  Ingredient.swift
//  Hestia
//
//  Created by Jonathan Long on 4/20/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

let INGREDIENT_MEASUREMENT_KEY = "measuerment"
let INGREDIENT_RECIPES_KEY = "recipes"
let INGREDIENT_NAME_KEY = "name"
let INGREDIENT_TOTAL_KEY = "total"
let INGREDIENT_PHOTO_KEY = "photo"

class Ingredient: PantryObject {
	//MARK: - Properties
	var name : String
	var total : Double = 0
	var measurement : String
	//    var recipes
	//    var photo
	
	//MARK: - Initializers
	override init(record: CKRecord, database : CKDatabase) {
		name = record[INGREDIENT_NAME_KEY] as! String
		measurement = record[INGREDIENT_MEASUREMENT_KEY] as! String
		if let recordTotal = record[INGREDIENT_TOTAL_KEY] as? Double {
			total = recordTotal
		}
		super.init(record : record, database : database)
	}
}
