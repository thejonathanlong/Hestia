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
        fetchAll(RecipeType) {[unowned self] (results, query, err) -> Void in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let recipes = self.recipesFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: recipes, forQuery: query)
            }
        }
    }
    
    //MARK: - Get Ingredients
    func getIngredient(named : String) {
        let namedPredicate = NSPredicate(format: "name LIKE %@", named)
        fetch(IngredientType, withPredicate: namedPredicate) {[unowned self] (results, query, err) -> Void in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let ingredients = self.ingredientsFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: ingredients, forQuery: query)
            }
        }
    }
    
    func getAllIngredients() {
        fetchAll(IngredientType) {[unowned self] (results, query, err) -> Void in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let ingredients = self.ingredientsFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: ingredients, forQuery: query)
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
    
    private func ingredientsFromRecords(records : [CKRecord]?) -> [Ingredient] {
        var ingredients = [Ingredient]()
        guard let results = records else {
            return []
        }
        for ingredient in results {
            let newRecipe = Ingredient(record: ingredient, database: self.publicDB)
            ingredients.append(newRecipe)
        }
        
        return ingredients
    }
}
