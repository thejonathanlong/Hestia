//
//  ViewController.swift
//  Hestia
//
//  Created by Jonathan Long on 4/5/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SessionRequesterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let requester = PinterestSessionRequester()
        requester.delegate = self
        
        requester.login()
        
    }
    
    func sessionRequester(_ session: SessionRequester, didHaveError error: NSError) {
        print("HUH..")
    }
    
    func sessionRequester(_ session: SessionRequester, didReceiveData data: Data?, response: URLResponse?) {
//		if let newData = data {
////			let url = URL(dataRepresentation: newData, relativeToURL: nil)
////			print("I GOT DATA! \(url)")
//		}
    }

}

