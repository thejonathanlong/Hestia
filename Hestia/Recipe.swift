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

class Recipe: HestiaObject {
	
	class var type : String {
		return "Recipe"
	}
	
	//MARK: - Properties
	var name : String
	var source : String?
	var instructions : String
	
	
	//MARK: - Initializers
	override init(record: CKRecord, database : CKDatabase) {
		name = record.value(forKey: RECIPE_NAME_KEY) as! String
		source = record.value(forKey: RECIPE_SOURCE_KEY) as? String
		instructions = record.value(forKey: RECIPE_INSTRUCTIONS_KEY) as! String
		super.init(record: record, database: database)
	}

}
