//
//  PantryRequestManager.swift
//  Hestia
//
//  Created by Jonathan Long on 4/20/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

class PantryRequestManager: DataRequestManager {
    //MARK: - Get Recipes
    func getRecipe(named : String) {
        let recipePredicate = NSPredicate(format: "name LIKE %@", named)
        fetch(RecipeType, withPredicate: recipePredicate) {[unowned self] (results, query, err) -> Void in
			self.didReceive(results, from: query, with: err)
		}
    }
    
    func getAllRecipes() {
        fetchAll(RecipeType) {[unowned self] (results, query, err) -> Void in
			self.didReceive(results, from: query, with: err)
        }
    }
    
    //MARK: - Get Ingredients
    func getIngredient(named : String) {
        let namedPredicate = NSPredicate(format: "name LIKE %@", named)
        fetch(IngredientType, withPredicate: namedPredicate) {[unowned self] (results, query, err) -> Void in
			self.didReceive(results, from: query, with: err)
        }
    }
    
    func getAllIngredients() {
		fetchAll(IngredientType) { (results, query, err) in
			self.didReceive(results, from: query, with: err)
		}
    }
    
    //MARK: - Private Interface
	private func didReceive(results : [CKRecord]?, from query : CKQuery, with error : NSError?) {
		if let err = error {
			self.delegate?.dataRequestManager(self, didReceiveError: err, forQuery: query)
		}
		else {
			let ingredients = self.pantryObject(from: results)
			self.delegate?.dataRequestManager(self, didReceiveResults: ingredients, forQuery: query)
		}
	}
	
	private func pantryObject(from records : [CKRecord]?) -> [PantryObject] {
		var pantryObjects = [PantryObject]()
		if let results = records {
			for obj in results {
				let newRecord = PantryObject(record: obj, database: self.publicDB)
				pantryObjects.append(newRecord)
			}
			return pantryObjects
		} else {
			return []
		}
		
	}
}
