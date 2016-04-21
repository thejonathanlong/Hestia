//
//  RecipeRequestManager.swift
//  Hestia
//
//  Created by Jonathan Long on 4/17/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

class RecipeRequestManager: DataRequestManager {
    func getRecipe(named : String) {
        let recipePredicate = NSPredicate(format: "name LIKE %@", named)
        let query = CKQuery(recordType: RecipeType, predicate: recipePredicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, err) in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let recipes = self.recipesFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: recipes, forQuery: query)
            }
        }
    }
    
    func getAllRecipes() {
        let recipePredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecipeType, predicate: recipePredicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, err) in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let recipes = self.recipesFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: recipes, forQuery: query)
            }
        }
    }
    
    //MARK: - Private Interface
    private func recipesFromRecords(records : [CKRecord]?) -> [Recipe] {
        var recipes = [Recipe]()
        guard let results = records else {
            return []
        }
        for recipe in results {
            let newRecipe = Recipe(record: recipe, database: self.publicDB)
            recipes.append(newRecipe)
        }
        
        return recipes
    }
}
