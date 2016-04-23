//
//  PantryObject.swift
//  Hestia
//
//  Created by Jonathan Long on 4/20/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

class PantryObject: NSObject {
    var record : CKRecord!
    weak var database : CKDatabase!
	
	override init() {
		super.init()
	}
	
	init(record : CKRecord, database : CKDatabase) {
		self.database = database
		self.record = record
	}
}
