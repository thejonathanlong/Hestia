//
//  PinterestSessionRequester.swift
//  Hestia
//
//  Created by Jonathan Long on 4/6/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit

class PinterestSessionRequester: SessionRequester {
    let appID = "4827511412509126534"
    let secret = "a88a9a0cf456243284e0676aa193ab2a95157c8443042b7cb97e0bb976add628"
    let state = NSUUID()
    override init() {
        super.init()
    }
    
    func login() {
        let url1 = NSURL(string: "https://api.pinterest.com/oauth/?response_type=code&redirect_uri=https://hestia.com/pinterest&client_id=\(appID)&scope=read_public&state=\(state.UUIDString)")
        print("\(url1)")
        if let url = NSURL(string: "https://api.pinterest.com/oauth/?response_type=code&redirect_uri=https://hestia.com/pinterest&client_id=\(appID)&scope=read_public&state=\(state.UUIDString)") {
            performRequest(.GET, url: url)
        }
        else {
            print("Something went wrong...");
        }
    }
}
