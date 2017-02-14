//
//  SessionRequester.swift
//  Hestia
//
//  Created by Jonathan Long on 4/5/16.
//  Copyright © 2016 Hiro. All rights reserved.
//

import UIKit
enum HTTPMethodType {
    case post
    case put
    case delete
    case get
}

protocol SessionRequesterDelegate {
    func sessionRequester(_ session : SessionRequester, didReceiveData data: Data?, response: URLResponse?)
    func sessionRequester(_ session : SessionRequester, didHaveError error: NSError)
}

class SessionRequester: NSObject, URLSessionDataDelegate {
    //MARK: Private Properties
    fileprivate var URLSession : Foundation.URLSession?
    fileprivate let URLDelegateQ = OperationQueue()
    fileprivate var baseURL : URL = URL(string: "")!
    
    //MARK: Public Properties
    var delegate : SessionRequesterDelegate?
    
    override init() {
        super.init()
        URLSession = Foundation.URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: URLDelegateQ)
    }
    
    convenience init(url : URL) {
        self.init()
        baseURL = url
    }
    
    //MARK: Public
    func performRequest(_ method : HTTPMethodType, endpoint : String) {
        let requestURL = baseURL.appendingPathComponent(endpoint)
        let request = NSMutableURLRequest(url: requestURL)
        switch method {
        case .post:
            request.httpMethod = "POST"
        case .delete:
            request.httpMethod = "DELETE"
        case .get:
            request.httpMethod = "GET"
        case .put:
            request.httpMethod = "PUT"
        }
        performRequest(request as URLRequest)
    }
    
    func performRequest(_ method : HTTPMethodType, url : URL) {
        let request = NSMutableURLRequest(url: url)
        switch method {
        case .post:
            request.httpMethod = "POST"
        case .delete:
            request.httpMethod = "DELETE"
        case .get:
            request.httpMethod = "GET"
        case .put:
            request.httpMethod = "PUT"
        }
        performRequest(request as URLRequest)
    }
    
    //MARK: Private
    fileprivate func performRequest(_ request: URLRequest) {
        let dataTask = URLSession?.dataTask(with: request, completionHandler: { (data, response, error) in
            if let err = error {
                self.delegate?.sessionRequester(self, didHaveError: err as NSError)
            } else {
                self.delegate?.sessionRequester(self, didReceiveData: data, response: response)
            }
        })
        dataTask?.resume()
    }
}
