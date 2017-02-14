//
//  HestiaObject.swift
//  Hestia
//
//  Created by Jonathan Long on 5/2/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
import CloudKit

class HestiaObject: NSObject {
	var record : CKRecord!
	weak var database : CKDatabase!
	
	init(record : CKRecord, database : CKDatabase) {
		super.init()
		self.database = database
		self.record = record
	}
}
