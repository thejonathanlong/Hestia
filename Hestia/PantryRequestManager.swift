//
//  PantryRequestManager.swift
//  Hestia
//
//  Created by Jonathan Long on 4/20/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

//let RecipeType = "Recipe"
//let IngredientType = "Ingredient"

class PantryRequestManager: DataRequestManager {
    //MARK: - Get Recipes
    func getRecipe(_ named : String) {
        let recipePredicate = NSPredicate(format: "name LIKE %@", named)
        fetch("Recipe", withPredicate: recipePredicate) {[unowned self] (results, query, err) -> Void in
			self.didReceive(results, from: query, with: err)
		}
    }
    
    func getAllRecipes() {
        fetchAll("Recipe") {[unowned self] (results, query, err) -> Void in
			self.didReceive(results, from: query, with: err)
        }
    }
    
    //MARK: - Get Ingredients
    func getIngredient(_ named : String) {
        let namedPredicate = NSPredicate(format: "name LIKE %@", named)
        fetch(Ingredient.type, withPredicate: namedPredicate) {[unowned self] (results, query, err) -> Void in
			self.didReceive(results, from: query, with: err)
        }
    }
    
    func getAllIngredients() {
		fetchAll(Ingredient.type) { (results, query, err) in
			self.didReceive(results, from: query, with: err)
		}
    }
    
    //MARK: - Private Interface
	fileprivate func didReceive(_ results : [CKRecord]?, from query : CKQuery, with error : NSError?) {
		if let err = error {
			self.delegate?.dataRequestManager(self, didReceiveError: err, forQuery: query)
		}
		else {
			let ingredients = self.pantryObject(from: results)
			self.delegate?.dataRequestManager(self, didReceiveResults: ingredients, forQuery: query)
		}
	}
	
	fileprivate func pantryObject(from records : [CKRecord]?) -> [HestiaObject] {
		var pantryObjects = [HestiaObject]()
		if let results = records {
			for obj in results {
				let newRecord = HestiaObject(record: obj, database: self.publicDB)
				pantryObjects.append(newRecord)
			}
			return pantryObjects
		} else {
			return []
		}
		
	}
}
