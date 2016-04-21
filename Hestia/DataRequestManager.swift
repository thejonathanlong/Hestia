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
    func dataRequestManager(manager : DataRequestManager, didReceiveSaveError error : NSError)
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
    
    //MARK: - GET
    func fetch(recordType : String, withPredicate predicate : NSPredicate, completion : ([CKRecord]?, CKQuery, NSError?) -> Void) {
        let query = CKQuery(recordType: RecipeType, predicate: predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, err) in
            completion(results, query, err)
        }
    }
    func fetchAll(recordType: String, completion : ([CKRecord]?, CKQuery, NSError?) -> Void) {
        fetch(recordType, withPredicate: NSPredicate(value: true), completion: completion)
    }
    
    func save(record : CKRecord, completion : (CKRecord?, NSError?) -> Void) {
        publicDB.saveRecord(record) { (record, err) -> Void in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveSaveError: error)
            }
        }
    }
    
}
