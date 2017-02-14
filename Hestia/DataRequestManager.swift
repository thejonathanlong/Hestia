//
//  DataRequestManager.swift
//  Hestia
//
//  Created by Jonathan Long on 4/14/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

protocol DataRequestManagerDelegate {
    func dataRequestManager(_ manager : DataRequestManager, didReceiveError error : NSError, forQuery query : CKQuery)
    func dataRequestManager(_ manager : DataRequestManager, didReceiveSaveError error : NSError)
    func dataRequestManager(_ manager : DataRequestManager, didReceiveResults results : [AnyObject], forQuery query: CKQuery)
}

class DataRequestManager: NSObject {
    let container : CKContainer
    let publicDB : CKDatabase
    let privateDB : CKDatabase
    
    var delegate : DataRequestManagerDelegate?
    
    //MARK: - Initializers
    override init() {
        container = CKContainer.default()
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
    func fetch(_ recordType : String, withPredicate predicate : NSPredicate, completion : @escaping ([CKRecord]?, CKQuery, NSError?) -> Void) {
        let query = CKQuery(recordType: Recipe.type, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (results, err) in
            completion(results, query, err as NSError?)
        }
    }
    func fetchAll(_ recordType: String, completion : @escaping ([CKRecord]?, CKQuery, NSError?) -> Void) {
        fetch(recordType, withPredicate: NSPredicate(value: true), completion: completion)
    }
    
    func save(_ record : CKRecord, completion : (CKRecord?, NSError?) -> Void) {
        publicDB.save(record, completionHandler: { (record, err) -> Void in
            if let error = err {
                self.delegate?.dataRequestManager(self, didReceiveSaveError: error as NSError)
            }
        }) 
    }
    
}
