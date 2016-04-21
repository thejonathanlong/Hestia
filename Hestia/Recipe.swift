//
//  Recipe.swift
//  Hestia
//
//  Created by Jonathan Long on 4/20/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

let RECIPE_INGREDIENTS_KEY = "ingredients"
let RECIPE_INSTRUCTIONS_KEY = "instructions"
let RECIPE_NAME_KEY = "name"
let RECIPE_SOURCE_KEY = "source"
let RECIPE_PHOTO_KEY = "photo"

class Recipe: PantryObject {
	
	//MARK: - Properties
	var name : String
	var source : String?
	var instructions : String
	
	//MARK: - Initializers
	init(record: CKRecord, database : CKDatabase) {
		name = record.valueForKey(RECIPE_NAME_KEY) as! String
		source = record.valueForKey(RECIPE_SOURCE_KEY) as? String
		instructions = record.valueForKey(RECIPE_INSTRUCTIONS_KEY) as! String
		super.init()
		self.database = database
		self.record = record
	}

}
