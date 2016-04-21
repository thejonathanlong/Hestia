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
    
    func sessionRequester(session: SessionRequester, didHaveError error: NSError) {
        print("HUH..")
    }
    
    func sessionRequester(session: SessionRequester, didReceiveData data: NSData?, response: NSURLResponse?) {
        do {
            if let newData = data {
                let url = NSURL(dataRepresentation: newData, relativeToURL: nil)
                print("I GOT DATA! \(url)")
            }
        } catch let err{
            print("There was an error...\(err)")
        }
        
    }

}

