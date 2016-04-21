//
//  SessionRequester.swift
//  Hestia
//
//  Created by Jonathan Long on 4/5/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
enum HTTPMethodType {
    case POST
    case PUT
    case DELETE
    case GET
}

protocol SessionRequesterDelegate {
    func sessionRequester(session : SessionRequester, didReceiveData data: NSData?, response: NSURLResponse?)
    func sessionRequester(session : SessionRequester, didHaveError error: NSError)
}

class SessionRequester: NSObject, NSURLSessionDataDelegate {
    //MARK: Private Properties
    private var URLSession : NSURLSession?
    private let URLDelegateQ = NSOperationQueue()
    private var baseURL : NSURL = NSURL(string: "")!
    
    //MARK: Public Properties
    var delegate : SessionRequesterDelegate?
    
    override init() {
        super.init()
        URLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: URLDelegateQ)
    }
    
    convenience init(url : NSURL) {
        self.init()
        baseURL = url
    }
    
    //MARK: Public
    func performRequest(method : HTTPMethodType, endpoint : String) {
        let requestURL = baseURL.URLByAppendingPathComponent(endpoint)
        let request = NSMutableURLRequest(URL: requestURL)
        switch method {
        case .POST:
            request.HTTPMethod = "POST"
        case .DELETE:
            request.HTTPMethod = "DELETE"
        case .GET:
            request.HTTPMethod = "GET"
        case .PUT:
            request.HTTPMethod = "PUT"
        }
        performRequest(request)
    }
    
    func performRequest(method : HTTPMethodType, url : NSURL) {
        let request = NSMutableURLRequest(URL: url)
        switch method {
        case .POST:
            request.HTTPMethod = "POST"
        case .DELETE:
            request.HTTPMethod = "DELETE"
        case .GET:
            request.HTTPMethod = "GET"
        case .PUT:
            request.HTTPMethod = "PUT"
        }
        performRequest(request)
    }
    
    //MARK: Private
    private func performRequest(request: NSURLRequest) {
        let dataTask = URLSession?.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            if let err = error {
                self.delegate?.sessionRequester(self, didHaveError: err)
            } else {
                self.delegate?.sessionRequester(self, didReceiveData: data, response: response)
            }
        })
        dataTask?.resume()
    }
}
