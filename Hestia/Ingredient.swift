//
//  Ingredient.swift
//  Hestia
//
//  Created by Jonathan Long on 4/17/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

let INGREDIENT_MEASUREMENT_KEY = "measuerment"
let INGREDIENT_RECIPES_KEY = "recipes"
let INGREDIENT_NAME_KEY = "name"
let INGREDIENT_TOTAL_KEY = "total"
let INGREDIENT_PHOTO_KEY = "photo"

class Ingredient: NSObject {
    var record : CKRecord!
    weak var database : CKDatabase!
    
    //MARK: - Properties
    var name : String
    var total : Double = 0
    var measurement : String
//    var recipes
//    var photo
    
    //MARK: - Initializers
    init(record: CKRecord, database : CKDatabase) {
        self.database = database
        self.record = record
        name = record[INGREDIENT_NAME_KEY] as! String
        measurement = record[INGREDIENT_MEASUREMENT_KEY] as! String
        if let recordTotal = record[INGREDIENT_TOTAL_KEY] as? Double {
            total = recordTotal
        }
        super.init()
    }
}
