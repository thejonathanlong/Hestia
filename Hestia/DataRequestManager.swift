//
//  DataRequestManager.swift
//  Hestia
//
//  Created by Jonathan Long on 4/14/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

let RecipeType = "Recipe"
let IngredientType = "Ingredient"

protocol DataRequestManagerDelegate {
    func dataRequestManager(manager : DataRequestManager, didReceiveError error : NSError, forQuery query : CKQuery)
    func dataRequestManager(manager : DataRequestManager, didReceiveResults results : [AnyObject], forQuery query: CKQuery)
}

class DataRequestManager: NSObject {
    let container : CKContainer
    let publicDB : CKDatabase
    let privateDB : CKDatabase
    
    var delegate : DataRequestManagerDelegate?
    
    //MARK: - Initializers
    override init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
        delegate = nil
        super.init()
    }
    
    convenience init(delegate : AnyObject) {
        self.init()
        self.delegate = delegate as? DataRequestManagerDelegate
    }
    
    func fetch(recordType : String, withPredicate predicate : NSPredicate) {
        let query = CKQuery(recordType: RecipeType, predicate: predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, err) in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let queryResults = self.recipesFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: queryResults, forQuery: query)
            }
        }
    }
    
    func fetchAll(recordType: String) {
        fetch(recordType, withPredicate: NSPredicate(value: true))
    }
    
    //MARK: - Ingredients
    func getIngredient(named : String) {
        let namedPredicate = NSPredicate(format: "name LIKE %@", named)
        let query = CKQuery(recordType: IngredientType, predicate: namedPredicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, err) in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let ingredients = self.recipesFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: ingredients, forQuery: query)
            }
        }
    }
    
    func getAllIngredients() {
        let recipePredicate = NSPredicate(value: true)
        let query = CKQuery(recordType: IngredientType, predicate: recipePredicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, err) in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveError: error, forQuery: query)
            }
            else {
                let ingredients = self.recipesFromRecords(results)
                self.delegate?.dataRequestManager(self, didReceiveResults: ingredients, forQuery: query)
            }
        }
    }
    
}
